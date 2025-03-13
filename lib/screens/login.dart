import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _checkLastLoggedInUser();
  }

  void _checkLastLoggedInUser() async {
    String? userId = await _databaseHelper.getLastLoggedInUser();
    if (userId != null) {
      String? username = await _databaseHelper.getUsername(userId);
      if (username != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(userId: userId, username: username),
          ),
        );
      }
    }
  }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    User? user = await _databaseHelper.getUser(username, password);
    if (user != null) {
      await _databaseHelper.saveLastLoggedInUser(user.id);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(userId: user.id, username: user.username),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}