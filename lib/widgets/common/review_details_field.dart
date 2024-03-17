import 'package:flutter/material.dart';

// Custom Field to display details in Review
class ReviewDetailsField extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? content;
  const ReviewDetailsField({
    super.key,
    required this.icon,
    required this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (content != null)
          Text(
            content!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
          ),
      ],
    );
  }
}
