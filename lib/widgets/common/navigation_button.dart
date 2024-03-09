import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final Widget icon;
  final String labelText;
  final VoidCallback onPressed;
  const NavigationButton({
    super.key,
    required this.icon,
    required this.labelText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            )),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            Text(labelText, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
