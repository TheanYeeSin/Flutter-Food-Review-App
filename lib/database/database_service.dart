import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseService {
  static const int _version = 1;
  static const String _databaseName = 'FoodReviews.db';

  static Future<Database> _getDatabase() async {
    final path = await getDatabasesPath();
    final fullPath = join(path, _databaseName);
    return await openDatabase(fullPath, version: _version,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE Category(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT NOT NULL,
          image BLOB
        )
      ''');
      await db.execute('''
          CREATE TABLE Review(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          restaurantName TEXT NOT NULL,
          location TEXT NOT NULL,
          description TEXT NOT NULL,
          categories TEXT,
          foodAvailable TEXT,
          rating DOUBLE NOT NULL,
          additionalReview TEXT,
          createdTime TEXT NOT NULL,
          isFavourite INTEGER NOT NULL,
          image BLOB
        )
      ''');
    });
  }

  static Future<int> addCategory(Category category) async {
    final db = await _getDatabase();
    return await db.insert('Category', category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateCategory(Category category) async {
    final db = await _getDatabase();
    return await db.update('Category', category.toJson(),
        where: 'id = ?',
        whereArgs: [category.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteCategory(Category category) async {
    final db = await _getDatabase();
    return await db
        .delete('Category', where: 'id = ?', whereArgs: [category.id]);
  }

  static Future<List<Category>?> getAllCategories() async {
    final db = await _getDatabase();
    const orderBy = 'name ASC';
    final List<Map<String, dynamic>> maps =
        await db.query('Category', orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
          maps.length, (index) => Category.fromJson(maps[index]));
    } else {
      return null;
    }
  }

  static Future<int> addReview(Review review) async {
    final db = await _getDatabase();
    return await db.insert('Review', review.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateReview(Review review) async {
    final db = await _getDatabase();
    return await db.update('Review', review.toJson(),
        where: 'id = ?',
        whereArgs: [review.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteReview(Review review) async {
    final db = await _getDatabase();
    return await db.delete('Review', where: 'id = ?', whereArgs: [review.id]);
  }

  static Future<List<Review>?> getAllReviews(
      {String orderBy = 'restaurantName ASC'}) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query('Review', orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
          maps.length, (index) => Review.fromJson(maps[index]));
    } else {
      return null;
    }
  }

  static Future<Review> getReviewById(int reviewId) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query('Review', where: 'id = ?', whereArgs: [reviewId]);
    if (maps.isNotEmpty) {
      return Review.fromJson(maps.first);
    } else {
      throw Exception('ID $reviewId not found');
    }
  }

  static Future<List<Review>?> getReviewsByColumn(
      String columnName, String columnValue,
      {String orderBy = 'restaurantName ASC'}) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('Review',
        orderBy: orderBy,
        where: '$columnName LIKE ? OR $columnName LIKE ? OR $columnName LIKE ?',
        whereArgs: ['%$columnValue', '%$columnValue,%', '%, $columnValue, %']);
    if (maps.isNotEmpty) {
      return List.generate(
          maps.length, (index) => Review.fromJson(maps[index]));
    } else {
      return null;
    }
  }

  static Future<int> updateReviewFavourite(
      int reviewId, int isFavourite) async {
    final db = await _getDatabase();
    return await db.update('Review', {'isFavourite': isFavourite},
        where: 'id = ?', whereArgs: [reviewId]);
  }

  static backupDatabase() async {
    final db = await _getDatabase();
    await db.close();
    var externalStatus = await Permission.manageExternalStorage.status;
    if (!externalStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
    try {
      DateTime now = DateTime.now();
      final dbFolder = await getDatabasesPath();
      File source = File('$dbFolder/FoodReviews.db');
      Directory copyTo = Directory('/storage/emulated/0/Tabemashou Backup');
      await copyTo.create();
      await source.copy(join(copyTo.path,
          'FoodReviews_${now.day}_${now.month}_${now.year}-${now.hour}_${now.minute}.db'));
    } catch (e) {
      print(e);
    }
  }

  static restoreDatabase(File source) async {
    final db = await _getDatabase();
    await db.close();
    var externalStatus = await Permission.manageExternalStorage.status;
    if (!externalStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
    try {
      final dbFolder = await getDatabasesPath();
      await source.copy('$dbFolder/FoodReviews.db');
    } catch (e) {
      print(e);
    }
  }

  static deleteDatabase() async {
    final db = await _getDatabase();
    await db.close();
    final dbFolder = await getDatabasesPath();
    File source = File('$dbFolder/FoodReviews.db');
    await source.delete();
  }

  static Future<bool> isValidDatabaseFile(File file) async {
    // Check if the file has the correct extension
    if (!file.path.endsWith('db')) {
      return false;
    }

    // Open the database
    Database database;
    try {
      database = await openDatabase(file.path);
    } catch (e) {
      print("Error opening database: $e");
      return false;
    }

    // Check if the "review" table exists
    bool reviewTableExists = false;
    try {
      var result = await database
          .query('sqlite_master', where: 'name = ?', whereArgs: ['Review']);
      reviewTableExists = result.isNotEmpty;
    } catch (e) {
      print("Error checking 'review' table: $e");
    }

    // Check if the "categories" table exists
    bool categoryTableExists = false;
    try {
      var result = await database
          .query('sqlite_master', where: 'name = ?', whereArgs: ['Category']);
      categoryTableExists = result.isNotEmpty;
    } catch (e) {
      print("Error checking 'categories' table: $e");
    }

    // Close the database
    await database.close();

    // Return true if both tables exist, otherwise false
    return reviewTableExists && categoryTableExists;
  }
}
