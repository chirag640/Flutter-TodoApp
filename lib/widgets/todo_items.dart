import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoItems extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onTodoChange;
  final Function(String) onTodoDelete;

  const TodoItems({
    super.key,
    required this.todo,
    required this.onTodoChange,
    required this.onTodoDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: theme.colorScheme.surface,
        leading: todo.isCompleted!
            ? Icon(Icons.check_box, color: theme.primaryColor)
            : Icon(Icons.check_box_outline_blank, color: theme.disabledColor),
        title: Text(
          todo.title.toString(),
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16,
            decoration: todo.isCompleted!
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: theme.colorScheme.error,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: theme.colorScheme.onError,
            icon: const Icon(Icons.delete),
            iconSize: 18,
            onPressed: () {
              onTodoDelete(todo.id!);
            },
          ),
        ),
      ),
    );
  }
}