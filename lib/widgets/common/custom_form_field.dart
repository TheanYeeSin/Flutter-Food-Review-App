import 'package:flutter/material.dart';
import 'package:foodreviewapp/utils/validator.dart';

// Custom Made Form Field for Review/Category/Checklist Form
class CustomFormField<T> extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final double? height;
  final String labelText;
  final String? errorText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final CustomValidator<T>? validator;
  final EdgeInsets? margin;
  final bool readOnly;

  const CustomFormField({
    super.key,
    this.controller,
    this.maxLines,
    this.height,
    required this.labelText,
    this.errorText,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.margin,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: prefixIcon,
          ),
          labelText: labelText,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => validator?.call(value as T, errorText!),
      ),
    );
  }
}
