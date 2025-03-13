class Todo {
  String? id;
  String? title;
  bool? isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted! ? 1 : 0,
    };
  }

  static List<Todo> todos = [];
}