import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';

class CounterWidget extends StatefulWidget {
  final String? columnName;
  final String? columnValue;
  final int? count;

  const CounterWidget(
      {super.key, this.columnName, this.columnValue, this.count});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int reviewCount = 0;

  _countReview() async {
    var reviews = widget.columnName != null && widget.columnValue != null
        ? await DatabaseService.getReviewsByColumn(
            widget.columnName!, widget.columnValue!)
        : await DatabaseService.getAllReviews();
    setState(() {
      reviewCount = reviews?.length ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.count != null) {
      setState(() {
        reviewCount = widget.count!;
      });
    } else {
      _countReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        padding:
            const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[600]!),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey[400]),
        child: Text('$reviewCount',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)));
  }
}
