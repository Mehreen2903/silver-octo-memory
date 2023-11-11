import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';


//AREA
void showNewAreaDialog(BuildContext context) {
  TextEditingController areaTitleController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('New Area'),
        content: TextField(
          controller: areaTitleController,
          decoration: InputDecoration(
            hintText: 'Area Title',
            labelText: 'Outlined', // This will be the label text on the outline
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface), // Label style
            floatingLabelBehavior: FloatingLabelBehavior.always, // Label will always float above the field
            border: OutlineInputBorder(), // Outlined border
            helperText: 'Supporting text', // Helper text below the field
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // Handle the area title submission
              print('New Area Title: ${areaTitleController.text}');
              Navigator.pop(context); // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}

//GOAL
void showNewGoalDialog(BuildContext context) {
  TextEditingController goalTitleController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  DateTime? startDate;
  DateTime? deadline;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> _pickStartDate(BuildContext context) async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: startDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null && pickedDate != startDate) {
              setState(() {
                startDate = pickedDate;
              });
            }
          }

          Future<void> _pickDeadline(BuildContext context) async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: deadline ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null && pickedDate != deadline) {
              setState(() {
                deadline = pickedDate;
              });
            }
          }

          return AlertDialog(
            title: Text('New Goal'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: goalTitleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Goal Title',
                      hintText: 'Enter the goal title',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: areaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Area',
                      hintText: 'Enter the related area',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListTile(
                    title: Text('Start Date'),
                    subtitle: Text(
                      startDate == null ? 'Pick a date' : DateFormat('yyyy-MM-dd').format(startDate!),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _pickStartDate(context),
                  ),
                  ListTile(
                    title: Text('Deadline'),
                    subtitle: Text(
                      deadline == null ? 'Pick a date' : DateFormat('yyyy-MM-dd').format(deadline!),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _pickDeadline(context),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Handle the goal submission
                  print('Goal Title: ${goalTitleController.text}');
                  print('Area: ${areaController.text}');
                  print('Start Date: ${startDate?.toIso8601String()}');
                  print('Deadline: ${deadline?.toIso8601String()}');
                  Navigator.pop(context); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    },
  );
}

//TASK
enum TaskType { goal, nonGoal }

void showNewTaskDialog(BuildContext context) {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TaskType selectedTaskType = TaskType.goal;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> _selectDate(BuildContext context) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          }

          Future<void> _selectTime(BuildContext context) async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null && picked != selectedTime) {
              setState(() {
                selectedTime = picked;
              });
            }
          }

          return AlertDialog(
            title: Text('New Task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text(
                          'Goal',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedTaskType == TaskType.goal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        checkmarkColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,  // This will set the checkmark color
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTaskType = TaskType.goal;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text(
                          'Non-Goal',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedTaskType == TaskType.nonGoal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        checkmarkColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,  // This will set the checkmark color
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTaskType = TaskType.nonGoal;
                          });
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text('Date'),
                    subtitle: Text(
                      selectedDate == null ? 'Pick a date' : DateFormat('yyyy-MM-dd').format(selectedDate!),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  ListTile(
                    title: Text('Time'),
                    subtitle: Text(
                      selectedTime == null ? 'Pick a time' : selectedTime!.format(context),
                    ),
                    trailing: Icon(Icons.access_time),
                    onTap: () => _selectTime(context),
                  ),
                  // Priority field can be added here as needed.
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // TODO: Handle the task submission
                  Navigator.pop(context); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    },
  );
}

//REPEATING TASK
enum RepeatingTaskType { goal, nonGoal }
enum IntervalType { days, weeks, months }

void showNewRepeatingTaskDialog(BuildContext context) {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  RepeatingTaskType selectedTaskType = RepeatingTaskType.goal;
  IntervalType selectedIntervalType = IntervalType.days;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> _selectDate(BuildContext context) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          }

          Future<void> _selectTime(BuildContext context) async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null && picked != selectedTime) {
              setState(() {
                selectedTime = picked;
              });
            }
          }

          List<Widget> buildIntervalTypeChips() {
            return IntervalType.values.map((interval) {
              return ChoiceChip(
                label: Text(describeEnum(interval).capitalize()),
                selected: selectedIntervalType == interval,
                selectedColor: Theme.of(context).colorScheme.primary,
                onSelected: (bool isSelected) {
                  setState(() {
                    if (isSelected) {
                      selectedIntervalType = interval;
                    }
                  });
                },

                labelStyle: TextStyle(
                  color: selectedIntervalType == interval
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]
                    : Colors.grey[300],
                checkmarkColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              );
            }).toList();
          }

          return AlertDialog(
            title: Text('New Repeating Task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ChoiceChip(
                        label: Text('Goal'),
                        selected: selectedTaskType == RepeatingTaskType.goal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTaskType = RepeatingTaskType.goal;
                          });
                        },
                        labelStyle: TextStyle(
                          color: selectedTaskType == RepeatingTaskType.goal
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        checkmarkColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      SizedBox(width: 8.0),
                      ChoiceChip(
                        label: Text('Non-Goal'),
                        selected: selectedTaskType == RepeatingTaskType.nonGoal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTaskType = RepeatingTaskType.nonGoal;
                          });
                        },
                        labelStyle: TextStyle(
                          color: selectedTaskType == RepeatingTaskType.nonGoal
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        checkmarkColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  ListTile(
                    title: Text('Date'),
                    subtitle: Text(selectedDate == null ? 'Pick a date' : DateFormat('yyyy-MM-dd').format(selectedDate!)),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  ListTile(
                    title: Text('Time'),
                    subtitle: Text(selectedTime == null ? 'Pick a time' : selectedTime!.format(context)),
                    trailing: Icon(Icons.access_time),
                    onTap: () => _selectTime(context),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: frequencyController,
                    decoration: InputDecoration(
                      labelText: 'Frequency',
                      border: OutlineInputBorder(),
                      hintText: 'e.g., Every 1 week(s)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: IntervalType.values.map((interval) {
                      return ChoiceChip(
                        label: Text(describeEnum(interval).capitalize()),
                        selected: selectedIntervalType == interval,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedIntervalType = interval;
                          });
                        },
                        labelStyle: TextStyle(
                          color: selectedIntervalType == interval
                              ? Colors.white
                              : Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        backgroundColor: selectedIntervalType == interval
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                            : Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        checkmarkColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Handle the repeating task submission
                  print('Task Title: ${taskTitleController.text}');
                  print('Description: ${descriptionController.text}');
                  print('Date: ${selectedDate?.toIso8601String()}');
                  print('Time: ${selectedTime?.format(context)}');
                  print('Frequency: ${frequencyController.text}');
                  print('Interval: ${describeEnum(selectedIntervalType)}');
                  Navigator.pop(context); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    },
  );
}

// Extension method to capitalize strings.
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}