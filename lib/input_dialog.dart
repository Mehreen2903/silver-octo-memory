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
                            color: selectedTaskType == TaskType.goal
                                ? Colors.white
                                : Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedTaskType == TaskType.goal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        checkmarkColor: Colors.white, // Checkmark color is always white for visibility
                        onSelected: (bool isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedTaskType = TaskType.goal;
                            }
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text(
                          'Non-Goal',
                          style: TextStyle(
                            color: selectedTaskType == TaskType.nonGoal
                                ? Colors.white
                                : Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedTaskType == TaskType.nonGoal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        checkmarkColor: Colors.white, // Checkmark color is always white for visibility
                        onSelected: (bool isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedTaskType = TaskType.nonGoal;
                            }
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
enum WeekDay { mon, tue, wed, thu, fri, sat, sun }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

void showNewRepeatingTaskDialog(BuildContext context) {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController dayOfMonthController = TextEditingController();
  RepeatingTaskType selectedTaskType = RepeatingTaskType.goal;
  IntervalType? selectedIntervalType;
  List<WeekDay> selectedWeekDays = [];
  DateTime? startDate;
  DateTime? endDate;

  StateSetter? dialogSetState;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      startDate = picked;
      if (dialogSetState != null) {
        dialogSetState!(() {}); // Update the UI
      }
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? (startDate ?? DateTime.now()),
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate) {
      endDate = picked;
      if (dialogSetState != null) {
        dialogSetState!(() {}); // Update the UI
      }
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          dialogSetState = setState;
          return AlertDialog(
            title: Text('New Repeating Task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Task Title Field
                  TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  // Description Field
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  // Task Type Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Goal Chip
                      ChoiceChip(
                        label: Text('Goal'),
                        selected: selectedTaskType == RepeatingTaskType.goal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool isSelected) {
                          setState(() {
                            selectedTaskType = RepeatingTaskType.goal;
                          });
                        },
                        labelStyle: TextStyle(
                          color: selectedTaskType == RepeatingTaskType.goal
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        checkmarkColor: Colors.white,
                      ),
                      SizedBox(width: 8.0),

                      // Non-Goal Chip
                      ChoiceChip(
                        label: Text('Non-Goal'),
                        selected: selectedTaskType == RepeatingTaskType.nonGoal,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (bool isSelected) {
                          setState(() {
                            selectedTaskType = RepeatingTaskType.nonGoal;
                          });
                        },
                        labelStyle: TextStyle(
                          color: selectedTaskType == RepeatingTaskType.nonGoal
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        checkmarkColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),

                  // Start Date Picker
                  ListTile(
                    title: Text('Start Date'),
                    subtitle: Text(
                      startDate == null
                          ? 'Pick a start date'
                          : DateFormat('dd-MM-yyyy').format(startDate!),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectStartDate(context),
                  ),


                  // End Date Picker
                  ListTile(
                    title: Text('End Date'),
                    subtitle: Text(
                      endDate == null
                          ? 'Pick an end date'
                          : DateFormat('dd-MM-yyyy').format(endDate!),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectEndDate(context),
                  ),
                  SizedBox(height: 8.0),

                  // Frequency Field
                  TextField(
                    controller: frequencyController,
                    decoration: InputDecoration(
                      labelText: 'Frequency',
                      border: OutlineInputBorder(),
                      hintText: 'e.g., Every 2 days',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8.0),

                  // Interval Dropdown
                  DropdownButtonFormField<IntervalType>(
                    decoration: InputDecoration(
                      labelText: 'Interval',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedIntervalType,
                    onChanged: (IntervalType? newValue) {
                      setState(() {
                        selectedIntervalType = newValue;
                      });
                    },
                    items: IntervalType.values.map((interval) {
                      return DropdownMenuItem(
                        value: interval,
                        child: Text(interval.toString().split('.').last.capitalize()),
                      );
                    }).toList(),
                  ),

                  // Weekday Selection for 'weeks' Interval
                  if (selectedIntervalType == IntervalType.weeks) ...[
                    Text('Select Days of the Week'),
                    Wrap(
                      spacing: 8.0,
                      children: WeekDay.values.map((day) {
                        return FilterChip(
                          label: Text(day.toString().split('.').last.capitalize()),
                          selected: selectedWeekDays.contains(day),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedWeekDays.add(day);
                              } else {
                                selectedWeekDays.remove(day);
                              }
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primary,
                          labelStyle: TextStyle(
                            color: selectedWeekDays.contains(day)
                                ? Colors.white
                                : null,
                          ),
                          backgroundColor: selectedWeekDays.contains(day)
                              ? null
                              : Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          checkmarkColor: Colors.white,
                        );
                      }).toList(),
                    ),
                  ],

                  // Day of Month Field for 'months' Interval
                  if (selectedIntervalType == IntervalType.months)
                    TextField(
                      controller: dayOfMonthController,
                      decoration: InputDecoration(
                        labelText: 'Day(s) of the Month',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., 15, or 1,15,30',
                      ),
                    ),
                ],
              ),
            ),
            actions: <Widget>[
              // OK Button
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Collect all the data and use it as needed
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
