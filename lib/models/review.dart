import 'dart:typed_data';

class Review {
  final int? id;
  final String restaurantName;
  final String location;
  final String description;
  final List<String>? categories;
  final List<String> foodAvailable;
  final double rating;
  final String? additionalReview;
  final DateTime createdTime;
  final bool isFavourite;
  final Uint8List? image;

  const Review(
      {this.id,
      required this.restaurantName,
      required this.location,
      required this.description,
      this.categories,
      required this.foodAvailable,
      required this.rating,
      this.additionalReview,
      required this.createdTime,
      this.isFavourite = false,
      this.image});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'location': location,
      'description': description,
      'categories': categories?.join(','),
      'foodAvailable': foodAvailable.map((item) => item.trim()).join(','),
      'rating': rating,
      'additionalReview': additionalReview,
      'createdTime': createdTime.toIso8601String(),
      'isFavourite': isFavourite ? 1 : 0,
      'image': image,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    List<String>? categoriesList;
    if (json['categories'] != null && json['categories'] is String) {
      categoriesList = (json['categories'] as String).split(',');
      categoriesList.removeWhere((category) => category.trim().isEmpty);
    }
    String? additionalReview = json['additionalReview'] as String?;
    if (additionalReview != null && additionalReview.trim().isEmpty) {
      additionalReview = null;
    }
    return Review(
      id: json['id'] as int,
      restaurantName: json['restaurantName'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      categories: categoriesList,
      foodAvailable: json['foodAvailable'].split(',') as List<String>,
      rating: json['rating'] as double,
      additionalReview: additionalReview,
      createdTime: DateTime.parse(json['createdTime'] as String),
      isFavourite: json['isFavourite'] == 1,
      image: json['image'] as Uint8List?,
    );
  }
}
