import 'package:flutter/material.dart';
import 'models.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List> _events = {};

  @override
  void initState() {
    super.initState();
    _loadTodosForSelectedDate(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('캘린더'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCalendar(),
            SizedBox(height: 16.0),
            Expanded(
              child: _buildTodoList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedDate = _selectedDate.subtract(Duration(days: 7));
              _loadTodosForSelectedDate(_selectedDate);
            });
          },
        ),
        Text(
          '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            setState(() {
              _selectedDate = _selectedDate.add(Duration(days: 7));
              _loadTodosForSelectedDate(_selectedDate);
            });
          },
        ),
      ],
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: (_events[_selectedDate] ?? []).length,
      itemBuilder: (context, index) {
        String title = _events[_selectedDate]![index];
        return ListTile(
          title: Text(title),
          subtitle: Text('${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
        );
      },
    );
  }

  // 선택한 날짜의 일정을 가져오는 함수
  void _loadTodosForSelectedDate(DateTime selectedDate) {
    setState(() {
      // TodoManager에서 모든 할 일 목록을 가져와서 날짜별로 그룹화
      List<Todo> todos = getTodosForDate(selectedDate);
      _events = {};
      for (var todo in todos) {
        DateTime date = DateTime(todo.date.year, todo.date.month, todo.date.day);
        _events[date] ??= [];
        _events[date]!.add(todo.title);
      }
    });
  }

  // 데이터를 가져오는 로직은 필요에 따라 수정이 필요합니다.
  List<Todo> getTodosForDate(DateTime date) {
    // 여기서는 임의의 데이터를 반환하도록 작성했습니다.
    // 실제 데이터 가져오는 로직을 구현해야 합니다.
    return [
      Todo(title: '일정1', date: DateTime(date.year, date.month, date.day)),
      Todo(title: '일정2', date: DateTime(date.year, date.month, date.day)),
      Todo(title: '일정3', date: DateTime(date.year, date.month, date.day)),
    ];
  }
}