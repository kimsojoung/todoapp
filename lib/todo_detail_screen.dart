import 'package:flutter/material.dart';
import 'todo_manager.dart';
import 'models.dart';

class TodoDetailScreen extends StatelessWidget {
  final int todoIndex;

  TodoDetailScreen({required this.todoIndex});

  @override
  Widget build(BuildContext context) {
    Todo todo = TodoManager.of(context).todos[todoIndex];
    TextEditingController _titleController = TextEditingController(text: todo.title);
    DateTime _selectedDate = todo.date;
    TimeOfDay _selectedTime = TimeOfDay.fromDateTime(todo.date);

    return Scaffold(
      appBar: AppBar(
        title: Text('일정 상세 정보'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 16.0),
            Text('날짜: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
            SizedBox(height: 16.0),
            Text('시간: ${_selectedTime.format(context)}'),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                // 날짜 선택
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null && pickedDate != _selectedDate) {
                  // 선택한 날짜 업데이트
                  _selectedDate = pickedDate;
                }
              },
              child: Text('날짜 선택'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // 시간 선택
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );

                if (pickedTime != null && pickedTime != _selectedTime) {
                  // 선택한 시간 업데이트
                  _selectedTime = pickedTime;
                }
              },
              child: const Text('시간 선택'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // 할 일 수정
                if (_titleController.text.isNotEmpty) {
                  Todo updatedTodo = Todo(
                    title: _titleController.text,
                    date: DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    ),
                  );
                  TodoManager.of(context).updateTodo(todoIndex, updatedTodo);
                  Navigator.pop(context); // 화면 닫기
                }
              },
              child: const Text('일정 수정'),
            ),
          ],
        ),
      ),
    );
  }
}