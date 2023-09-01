import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';

class CounterWidget extends StatefulWidget {
  final String columnName;
  final String columnValue;
  const CounterWidget(
      {super.key, required this.columnName, required this.columnValue});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int reviewCount = 0;

  _countReview() async {
    var reviews = await DatabaseService.getReviewsByColumn(
        widget.columnName, widget.columnValue);
    setState(() {
      reviewCount = reviews?.length ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _countReview();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey[200]),
        child:
            Text('$reviewCount', style: const TextStyle(color: Colors.black)));
  }
}
