import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/checklist_item.dart';
import 'package:foodreviewapp/screens/form_screens/review_form_screen.dart';

// Checklist item display widget
class ChecklistItemWidget extends StatefulWidget {
  final ChecklistItem checklistItem;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;
  const ChecklistItemWidget({
    super.key,
    required this.checklistItem,
    required this.onLongPress,
    required this.onDelete,
  });

  @override
  State<ChecklistItemWidget> createState() => _ChecklistItemWidgetState();
}

class _ChecklistItemWidgetState extends State<ChecklistItemWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.checklistItem.isChecked;
  }

  void _toggleChecked() async {
    await DatabaseService.updateChecklistItemChecked(
      widget.checklistItem.id!,
      isChecked ? 0 : 1,
    );
    setState(() {
      isChecked = !isChecked;
    });
    if (isChecked) {
      // ignore: use_build_context_synchronously
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewFormScreen(
            restaurantName: widget.checklistItem.name,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onLongPress: widget.onLongPress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: isChecked
            ? Colors.grey.withOpacity(0.15)
            : Colors.grey.withOpacity(0.45),
        leading: IconButton(
          icon: isChecked
              ? const Icon(Icons.check_circle_outlined)
              : const Icon(Icons.circle_outlined),
          onPressed: _toggleChecked,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          widget.checklistItem.name,
          style: TextStyle(
            fontSize: 16,
            decoration:
                isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: widget.onDelete,
        ),
      ),
    );
  }
}
