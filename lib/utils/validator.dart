typedef CustomValidator<T> = String? Function(T value, String errorText);

String? requiredString(String value, String errorText) {
  if (value.isEmpty && value.trim().isEmpty) {
    return errorText;
  }
  return null;
}
