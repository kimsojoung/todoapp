import 'package:flutter/material.dart';
import 'package:todoapp/calender_screen.dart';
import 'add_todo_screen.dart';
import 'calendar_screen.dart';
import 'todo_detail_screen.dart';
import 'todo_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  TodoManager _todoManager = TodoManager();

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (_currentIndex) {
      case 0:
        currentScreen = _buildTodoListScreen();
        break;
      case 1:
        currentScreen = AddTodoScreen();
        break;
      case 2:
        currentScreen = CalendarScreen();
        break;
      default:
        currentScreen = Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '할 일 목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '할 일 추가',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '캘린더',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }

  Widget _buildTodoListScreen() {
    return ListView.builder(
      itemCount: _todoManager.todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_todoManager.todos[index].title),
          subtitle: Text(
              '${_todoManager.todos[index].date.year}-${_todoManager.todos[index].date.month}-${_todoManager.todos[index].date.day}'),
          onTap: () {
            // 할 일 상세 정보 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoDetailScreen(todoIndex: index),
              ),
            );
          },
        );
      },
    );
  }
}