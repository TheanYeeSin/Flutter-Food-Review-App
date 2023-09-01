import 'dart:typed_data';

class Category {
  final int? id;
  final String name;
  final String description;
  final Uint8List? image;

  const Category(
      {this.id, required this.name, required this.description, this.image});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'image': image};
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as Uint8List?,
    );
  }
}
