import 'package:flutter/material.dart';
import 'task_card.dart';

// Mock data for unplanned tasks
final List<Map<String, dynamic>> mockUnplannedGoalTasks = [
  {
    'category': 'Personal',
    'task': 'Visit the dentist',
    'completedTasks': 1,
    'totalTasks': 1,
  },
  {
    'category': 'Health',
    'task': 'Schedule a yoga class',
    'completedTasks': 0,
    'totalTasks': 1,
  },
  {
    'category': 'Work',
    'task': 'Brainstorm project ideas',
    'completedTasks': 0,
    'totalTasks': 1,
  },
  {
    'category': 'Education',
    'task': 'Research online courses',
    'completedTasks': 0,
    'totalTasks': 1,
  },
];

final List<Map<String, dynamic>> mockUnplannedNonGoalTasks = [
  {'task': 'Reply to emails', 'completedTasks': 0, 'totalTasks': 5},
  {'task': 'Watch a movie', 'completedTasks': 0, 'totalTasks': 1},
  {'task': 'Buy groceries', 'completedTasks': 0, 'totalTasks': 1},
  {'task': 'Practice guitar', 'completedTasks': 1, 'totalTasks': 1},
];

class UnplannedTasks extends StatefulWidget {
  final ThemeData theme;

  UnplannedTasks({Key? key, required this.theme}) : super(key: key);

  @override
  _UnplannedTasksState createState() => _UnplannedTasksState();
}

class _UnplannedTasksState extends State<UnplannedTasks> {
  List<bool> isSelected = [true, false];  // to track which segment is selected

  @override
  Widget build(BuildContext context) {
    // Custom BoxDecoration to create the border style
    BoxDecoration boxDecoration(int index, int length) {
      if (index == 0) {
        return BoxDecoration(
          color: isSelected[index]
              ? widget.theme.colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
          border: Border.all(
            color: widget.theme.colorScheme.primary,
            width: 1,
          ),
        );
      } else if (index == length - 1) {
        return BoxDecoration(
          color: isSelected[index]
              ? widget.theme.colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          border: Border.all(
            color: widget.theme.colorScheme.primary,
            width: 1,
          ),
        );
      } else {
        return BoxDecoration(
          color: isSelected[index]
              ? widget.theme.colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          border: Border.all(
            color: widget.theme.colorScheme.primary,
            width: 1,
          ),
        );
      }
    }

    List<Widget> buildToggleButtons() {
      List<Widget> buttons = [];

      for (int i = 0; i < 2; i++) {
        buttons.add(
          InkWell(
            onTap: () {
              setState(() {
                for (int j = 0; j < isSelected.length; j++) {
                  isSelected[j] = j == i;
                }
              });
            },
            child: Container(
              decoration: boxDecoration(i, 2),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(i == 0 ? "Goal" : "Non-Goal",
                style: TextStyle(
                  color: isSelected[i] ? widget.theme.colorScheme.primary : null,
                ),
              ),
            ),
          ),
        );
      }

      return buttons;
    }

    return Column(
      children: [
        SizedBox(height: 16.0),
        // ToggleButtons for 'Goal' and 'Non-Goal' tasks
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildToggleButtons(),
        ),
        SizedBox(height: 16.0),
        if (isSelected[0])
          ...mockUnplannedGoalTasks.map((taskData) => TaskCard(
            theme: widget.theme,
            category: taskData['category'],
            task: taskData['task'],
            completedTasks: taskData['completedTasks'],
            totalTasks: taskData['totalTasks'],
          )).toList(),
        if (isSelected[1])
          ...mockUnplannedNonGoalTasks.map((taskData) => TaskCard(
            theme: widget.theme,
            task: taskData['task'],
            completedTasks: taskData['completedTasks'],
            totalTasks: taskData['totalTasks'],
          )).toList(),
      ],
    );
  }
}
