import 'package:flutter/material.dart';
import 'todo_manager.dart';
import 'models.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(height: 16.0),
            Text('날짜 선택: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text('날짜 선택'),
            ),
            SizedBox(height: 16.0),
            Text('시간 선택: ${_selectedTime.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );

                if (pickedTime != null && pickedTime != _selectedTime) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
              child: Text('시간 선택'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // 할 일 추가
                if (_titleController.text.isNotEmpty) {
                  TodoManager todoManager = TodoManager();
                  todoManager.addTodo(
                    Todo(
                      title: _titleController.text,
                      date: DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        _selectedTime.hour,
                        _selectedTime.minute,
                      ),
                    ),
                  );
                  Navigator.pop(context); // 화면 닫기
                }
              },
              child: Text('일정 추가'),
            ),
          ],
        ),
      ),
    );
  }}