import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final ThemeData theme;
  final String? category;
  final String task;
  final int completedTasks;
  final int totalTasks;
  final String? time;

  TaskCard({
    Key? key,
    required this.theme,
    this.category,
    required this.task,
    required this.completedTasks,
    required this.totalTasks,
    this.time,
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = widget.theme.colorScheme;
    double progress = widget.completedTasks / widget.totalTasks;

    return Card(
      elevation: 2,
      color: colorScheme.surface,
      // Add horizontal margin here
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust the horizontal value as needed
      child: ListTile(
        leading: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
          activeColor: widget.theme.colorScheme.primary,
        ),
        title: Text(
          widget.task,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.category != null)
              Text(
                widget.category!,
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: colorScheme.onSurface.withOpacity(0.3),
              color: colorScheme.primary,
            ),
            Text(
              '${widget.completedTasks}/${widget.totalTasks} (${(progress * 100).toStringAsFixed(0)}%)',
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
        trailing: widget.time != null
            ? Text(
          widget.time!,
          style: TextStyle(
            color: colorScheme.primary,
          ),
        )
            : null,
      ),
    );
  }
}
