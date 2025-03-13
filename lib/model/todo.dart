class Todo {
  String? id;
  String? title;
  bool? isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  static List<Todo> todos = [
    Todo(
      id: '1',
      title: 'Check Mail',
      isCompleted: true,
    ),
    Todo(
      id: '2',
      title: 'Buy Groceries',
    ),
    Todo(
      id: '3',
      title: 'Pay Bills',
    ),
    Todo(
      id: '4',
      title: 'Call Mom',
    ),
    Todo(
      id: '5',
      title: 'Meeting with Team',
    ),
  ];
}