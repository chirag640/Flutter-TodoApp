import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

class TodoItems extends StatelessWidget {
  final Todo todo;
  final onTodoChange;
  final onTodoDelete;
  const TodoItems({super.key ,required this.todo , required this.onTodoChange , required this.onTodoDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white,
        leading: todo.isCompleted! ? Icon(Icons.check_box, color: tdBlue,) : Icon(Icons.check_box_outline_blank, color: tdGrey,),
        title: Text(todo.title.toString(), style: TextStyle(
          color: tdBlack,
          fontSize: 16,
          decoration: todo.isCompleted! ? TextDecoration.lineThrough : TextDecoration.none,
        ),),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.delete),
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