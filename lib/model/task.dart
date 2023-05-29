class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  bool isFavorite;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    this.isFavorite = false,
  });

  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        dueDate == other.dueDate &&
        isCompleted == other.isCompleted &&
        isFavorite == other.isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dueDate.hashCode ^
        isCompleted.hashCode ^
        isFavorite.hashCode;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      isCompleted: json['isCompleted'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
    };
  }
} 