class Todo {
  String id;
  String? title;
  bool? isCompleted;
  String? userId;

  Todo({
    required this.id,
    this.title,
    this.isCompleted = false,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted! ? 1 : 0,
      'userId': userId,
    };
  }

  static List<Todo> todos = [];
}