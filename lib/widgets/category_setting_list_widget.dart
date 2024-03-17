import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/category.dart';

// Category setting list tile widget
class CategorySettingListWidget extends StatelessWidget {
  final Category category;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategorySettingListWidget({
    super.key,
    required this.category,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      child: Card(
        elevation: 8.0,
        child: InkWell(
          onDoubleTap: onEdit,
          onLongPress: onDelete,
          child: Ink(
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
              title: Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
              subtitle: Text(
                category.description,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
