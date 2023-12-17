import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'models.dart';

class TodoManager with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  // 기타 필요한 메소드 추가 가능

  // 예시: 할 일 삭제
  void deleteTodoAtIndex(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
      notifyListeners();
    }
  }

  static of(BuildContext context) {}
}
