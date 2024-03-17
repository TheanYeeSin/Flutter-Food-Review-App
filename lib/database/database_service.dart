import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/models/checklist_item.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:foodreviewapp/utils/constant.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseService {
  static Future<Database> _getDatabase() async {
    final path = await getDatabasesPath();
    final fullPath = join(path, databaseName);
    return await openDatabase(
      fullPath,
      version: databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $categoryTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            image BLOB
          )
        ''');
        await db.execute('''
          CREATE TABLE $reviewTableName(
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
        await db.execute('''
          CREATE TABLE $checklistItemTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            isChecked INTEGER NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE Category RENAME TO $categoryTableName');
          await db.execute('ALTER TABLE Review RENAME TO $reviewTableName');
          await db.execute('''
            CREATE TABLE $checklistItemTableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              isChecked INTEGER NOT NULL
            )
          ''');
        }
      },
    );
  }
  //=============================
  //CATEGORY
  //=============================

  static Future<int> addCategory(Category category) async {
    final db = await _getDatabase();
    return await db.insert(
      categoryTableName,
      category.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateCategory(Category category) async {
    final db = await _getDatabase();
    return await db.update(
      categoryTableName,
      category.toJson(),
      where: 'id = ?',
      whereArgs: [category.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteCategory(Category category) async {
    final db = await _getDatabase();
    return await db
        .delete(categoryTableName, where: 'id = ?', whereArgs: [category.id]);
  }

  static Future<List<Category>?> getAllCategories() async {
    final db = await _getDatabase();
    const orderBy = 'name ASC';
    final List<Map<String, dynamic>> maps =
        await db.query(categoryTableName, orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => Category.fromJson(maps[index]),
      );
    } else {
      return null;
    }
  }

  //=============================
  //REVIEW
  //=============================

  static Future<int> addReview(Review review) async {
    final db = await _getDatabase();
    return await db.insert(
      reviewTableName,
      review.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateReview(Review review) async {
    final db = await _getDatabase();
    return await db.update(
      reviewTableName,
      review.toJson(),
      where: 'id = ?',
      whereArgs: [review.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteReview(Review review) async {
    final db = await _getDatabase();
    return await db
        .delete(reviewTableName, where: 'id = ?', whereArgs: [review.id]);
  }

  static Future<List<Review>?> getAllReviews({
    String orderBy = 'restaurantName ASC',
  }) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(reviewTableName, orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => Review.fromJson(maps[index]),
      );
    } else {
      return null;
    }
  }

  static Future<Review> getReviewById(int reviewId) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(reviewTableName, where: 'id = ?', whereArgs: [reviewId]);
    if (maps.isNotEmpty) {
      return Review.fromJson(maps.first);
    } else {
      throw Exception('ID $reviewId not found');
    }
  }

  static Future<List<Review>?> getReviewsByColumn(
    String columnName,
    String columnValue, {
    String orderBy = 'restaurantName ASC',
  }) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      reviewTableName,
      orderBy: orderBy,
      where: '$columnName LIKE ? OR $columnName LIKE ? OR $columnName LIKE ?',
      whereArgs: ['%$columnValue', '%$columnValue,%', '%, $columnValue, %'],
    );
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => Review.fromJson(maps[index]),
      );
    } else {
      return null;
    }
  }

  static Future<int> updateReviewFavourite(
    int reviewId,
    int isFavourite,
  ) async {
    final db = await _getDatabase();
    return await db.update(
      reviewTableName,
      {'isFavourite': isFavourite},
      where: 'id = ?',
      whereArgs: [reviewId],
    );
  }

  //=============================
  //CHECKLISTITEM
  //=============================

  static Future<int> addChecklistItem(ChecklistItem item) async {
    final db = await _getDatabase();
    return await db.insert(
      checklistItemTableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateChecklistItem(ChecklistItem item) async {
    final db = await _getDatabase();
    return await db.update(
      checklistItemTableName,
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteChecklistItem(ChecklistItem item) async {
    final db = await _getDatabase();
    return await db
        .delete(checklistItemTableName, where: 'id = ?', whereArgs: [item.id]);
  }

  static Future<List<ChecklistItem>?> getAllChecklistItem() async {
    final db = await _getDatabase();
    const orderBy = 'name ASC';
    final List<Map<String, dynamic>> maps =
        await db.query(checklistItemTableName, orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => ChecklistItem.fromJson(maps[index]),
      );
    } else {
      return null;
    }
  }

  static Future<List<ChecklistItem>?> getUncheckChecklistItem() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db
        .query(checklistItemTableName, where: 'isChecked = ?', whereArgs: [0]);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => ChecklistItem.fromJson(maps[index]),
      );
    } else {
      return null;
    }
  }

  static Future<int> updateChecklistItemChecked(int id, int isChecked) async {
    final db = await _getDatabase();
    return await db.update(
      checklistItemTableName,
      {'isChecked': isChecked},
      where: 'id = ?',
      whereArgs: [id],
    );
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
      File source = File('$dbFolder/$databaseName');
      Directory copyTo = Directory('/storage/emulated/0/Tabemashou Backup');
      await copyTo.create();
      await source.copy(
        join(
          copyTo.path,
          'FoodReviews_${now.day}_${now.month}_${now.year}-${now.hour}_${now.minute}.db',
        ),
      );
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
      await source.copy('$dbFolder/$databaseName');
    } catch (e) {
      print(e);
    }
  }

  static deleteDatabase() async {
    final db = await _getDatabase();
    await db.close();
    final dbFolder = await getDatabasesPath();
    File source = File('$dbFolder/$databaseName');
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

    // Check if the "reviews" table exists
    bool reviewTableExists = false;
    try {
      var result = await database.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: [reviewTableName],
      );
      reviewTableExists = result.isNotEmpty;
    } catch (e) {
      print("Error checking 'reviews' table: $e");
    }

    // Check if the "categories" table exists
    bool categoryTableExists = false;
    try {
      var result = await database.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: [categoryTableName],
      );
      categoryTableExists = result.isNotEmpty;
    } catch (e) {
      print("Error checking 'categories' table: $e");
    }

    // Check if the "checklist items" table exists
    bool checklistItemTableExists = false;
    try {
      var result = await database.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: [checklistItemTableName],
      );
      checklistItemTableExists = result.isNotEmpty;
    } catch (e) {
      print("Error checking 'checklist items' table: $e");
    }

    // Close the database
    await database.close();

    // Return true if both tables exist, otherwise false
    return reviewTableExists && categoryTableExists && checklistItemTableExists;
  }
}
