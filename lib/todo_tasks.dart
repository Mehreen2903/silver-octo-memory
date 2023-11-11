import 'package:flutter/material.dart';
import 'task_card.dart';

// A mock data list to represent tasks, you will replace this with your actual data source
final List<Map<String, dynamic>> mockTodoTasks = [
  {
    'task': 'Pick up groceries',
    'category': 'Personal',
    'completedTasks': 1,
    'totalTasks': 1,
    'time': '09:00 AM',
  },
  {
    'task': 'Meeting with team',
    'category': 'Work',
    'completedTasks': 0,
    'totalTasks': 1,
    'time': '11:00 AM',
  },
  {
    'task': 'Doctor appointment',
    'category': 'Health',
    'completedTasks': 0,
    'totalTasks': 1,
    'time': '02:00 PM',
  },
  {
    'task': 'Complete project report',
    'category': 'Work',
    'completedTasks': 2,
    'totalTasks': 5,
    'time': '04:00 PM',
  },
  {
    'task': 'Read a book',
    'category': 'Leisure',
    'completedTasks': 0,
    'totalTasks': 1,
    'time': '07:00 PM',
  },
];

class TodoTasks extends StatelessWidget {
  final ThemeData theme;

  TodoTasks({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Normally, you'd fetch this data from your backend or local database
    List<TaskCard> taskList = mockTodoTasks.map((taskData) {
      return TaskCard(
        theme: theme,
        category: taskData['category'],
        task: taskData['task'],
        completedTasks: taskData['completedTasks'],
        totalTasks: taskData['totalTasks'],
        time: taskData['time'],
      );
    }).toList();

    return Column(
      children: taskList,
    );
  }
}
