import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Category selection dialog in Category form
class CategorySelectionDialog extends StatefulWidget {
  final List<Category> availableCategories;
  final List<String> selectedCategories;

  const CategorySelectionDialog({
    super.key,
    required this.availableCategories,
    required this.selectedCategories,
  });

  @override
  State<CategorySelectionDialog> createState() =>
      _CategorySelectionDialogState();
}

class _CategorySelectionDialogState extends State<CategorySelectionDialog> {
  List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(AppLocalizations.of(context)!.selectCategoriesDialogTitle),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: widget.availableCategories.map((category) {
            final isChecked = _selectedCategories.contains(category.name);
            return CheckboxListTile(
              title: Text(category.name),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedCategories.add(category.name);
                  } else {
                    _selectedCategories.remove(category.name);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          layoutBehavior: ButtonBarLayoutBehavior.constrained,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedCategories);
              },
              child: Text(AppLocalizations.of(context)!.okay),
            ),
          ],
        ),
      ],
    );
  }
}
