import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/todo_items.dart';
import 'package:todo_app/screens/settings.dart';
import 'package:todo_app/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _todoController = TextEditingController();
  List<Todo> _foundTodo = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper().getTodos();
    setState(() {
      _foundTodo = todos;
    });
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SearchBox(),
                ListViews(),
              ],
            ),
          ),
          bottomInput()
        ],
      ),
    );
  }

  Align bottomInput() {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a todo',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, right: 20),
            child: FloatingActionButton(
              onPressed: () => _handleTodoAdd(_todoController.text),
              backgroundColor: tdBlue,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Expanded ListViews() {
    final theme = Theme.of(context);

    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              "All Todos",
              style: theme.textTheme.headlineMedium,
            ),
          ),
          for (Todo todo in _foundTodo)
            TodoItems(
              todo: todo,
              onTodoChange: _handleTodoChange,
              onTodoDelete: _handleTodoDelete,
            ),
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) async {
    setState(() {
      todo.isCompleted = !todo.isCompleted!;
    });
    await DatabaseHelper().updateTodo(todo);
  }

  void _handleTodoDelete(String id) async {
    await DatabaseHelper().deleteTodo(id);
    _loadTodos();
  }

  void _handleTodoAdd(String title) async {
    if (title.isEmpty) return;
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    await DatabaseHelper().insertTodo(newTodo);
    _todoController.clear();
    _loadTodos();
  }

  Widget SearchBox() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: theme.appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey, fontSize: 18),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: tdGrey, size: 20),
          prefixIconConstraints: BoxConstraints(
            minWidth: 20,
            minHeight: 25,
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = _foundTodo;
    } else {
      results = _foundTodo
          .where((todo) => todo.title!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Profile':
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
                  break;
                case 'Settings':
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }
}