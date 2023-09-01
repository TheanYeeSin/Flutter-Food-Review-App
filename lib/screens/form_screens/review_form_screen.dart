import 'package:flutter/material.dart';
import 'package:foodreviewapp/widgets/review_form.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewFormScreen extends StatefulWidget {
  final Review? review;

  const ReviewFormScreen({super.key, this.review});

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.review == null
            ? AppLocalizations.of(context)!.addReviewTitle
            : AppLocalizations.of(context)!.editReviewTitle),
      ),
      body: ReviewForm(review: widget.review),
    );
  }
}
