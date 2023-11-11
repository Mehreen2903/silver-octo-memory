import 'package:flutter/material.dart';
import 'task_card.dart';

// Mock data for overdue tasks
final List<Map<String, dynamic>> mockOverdueTasks = [
  {
    'task': 'Finish project documentation',
    'category': 'Work',
    'completedTasks': 2,
    'totalTasks': 5,
    'time': 'Yesterday',
  },
  {
    'task': 'Gym subscription renewal',
    'category': 'Health',
    'completedTasks': 0,
    'totalTasks': 1,
    'time': '3 days ago',
  },
  {
    'task': 'Buy anniversary gift',
    'category': 'Personal',
    'completedTasks': 0,
    'totalTasks': 1,
    'time': '4 days ago',
  },
];


class OverdueTasks extends StatelessWidget {
  final ThemeData theme;

  OverdueTasks({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with your actual data fetching logic
    List<TaskCard> taskList = mockOverdueTasks.map((taskData) {
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
