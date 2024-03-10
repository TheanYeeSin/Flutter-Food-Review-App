import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/models/checklist_item.dart';

class ChecklistItemWidget extends StatefulWidget {
  final ChecklistItem checklistItem;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;
  const ChecklistItemWidget(
      {super.key,
      required this.checklistItem,
      required this.onLongPress,
      required this.onDelete});

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
        widget.checklistItem.id!, isChecked ? 0 : 1);
    setState(() {
      isChecked = !isChecked;
    });
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
        tileColor: Colors.grey.withOpacity(0.35),
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
            onPressed: widget.onDelete),
      ),
    );
  }
}
