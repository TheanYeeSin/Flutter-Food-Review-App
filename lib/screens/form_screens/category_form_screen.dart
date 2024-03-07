import 'package:foodreviewapp/widgets/form/category_form.dart';
import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryFormScreen extends StatefulWidget {
  final Category? category;
  const CategoryFormScreen({super.key, this.category});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null
            ? AppLocalizations.of(context)!.addCategoryTitle
            : AppLocalizations.of(context)!.editCategoryTitle),
      ),
      body: CategoryForm(category: widget.category),
    );
  }
}
