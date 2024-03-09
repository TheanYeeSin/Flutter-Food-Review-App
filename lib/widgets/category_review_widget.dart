import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/category.dart';
import 'package:foodreviewapp/widgets/counter_widget.dart';

class CategoryReviewWidget extends StatefulWidget {
  final Category category;
  final VoidCallback onPressed;
  const CategoryReviewWidget(
      {super.key, required this.category, required this.onPressed});

  @override
  State<CategoryReviewWidget> createState() => _CategoryReviewWidgetState();
}

class _CategoryReviewWidgetState extends State<CategoryReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: widget.onPressed,
          child: Ink(
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: widget.category.image != null
                      ? Image.memory(
                          widget.category.image!,
                          fit: BoxFit.fill,
                        )
                      : Image.asset('assets/images/default_category.png'),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    widget.category.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CounterWidget(
                    columnName: 'categories',
                    columnValue: widget.category.name,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
