class ChecklistItem {
  final int? id;
  final String name;
  final bool isChecked;

  const ChecklistItem({
    this.id,
    required this.name,
    this.isChecked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "isChecked": isChecked ? 1 : 0,
    };
  }

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'] as int,
      name: json['name'] as String,
      isChecked: json['isChecked'] == 1,
    );
  }
}
