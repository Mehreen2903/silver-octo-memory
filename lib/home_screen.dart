import 'package:flutter/material.dart';
import 'todo_tasks.dart'; // Ensure you have this file created with relevant widget
import 'overdue_tasks.dart'; // Ensure you have this file created with relevant widget
import 'unplanned_tasks.dart'; // Ensure you have this file created with relevant widget
import 'task_card.dart'; // Ensure you have this file created with relevant widget
import 'package:intl/intl.dart';

enum TaskCategory { todo, overdue, unplanned }

class HomeScreen extends StatefulWidget {
  final void Function(bool) toggleTheme;

  HomeScreen({Key? key, required this.toggleTheme}) : super(key: key); // Constructor with toggleTheme

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskCategory _selectedCategory = TaskCategory.todo;

  void _updateCategory(TaskCategory category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  String _formattedDate() {
    // Get the current date and format it to the desired format.
    DateTime now = DateTime.now();
    return DateFormat('MMMM dd, yyyy - EEEE').format(now);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column( // Your main content for HomeScreen starts here
          children: <Widget>[
            SizedBox(height: 16.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0), // Add vertical padding
                child: Text(
                  _formattedDate(), // This will display the current date
                  style: theme.textTheme.headline6,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildTaskSummaryCard(theme, 'To do', '3', TaskCategory.todo),
                _buildTaskSummaryCard(theme, 'Overdue', '4', TaskCategory.overdue),
                _buildTaskSummaryCard(theme, 'Unplanned', '7', TaskCategory.unplanned),
              ],
            ),
            SizedBox(height: 16.0),
            // No need for Expanded here anymore since SingleChildScrollView will handle the overflow
            _buildTaskCards(context, theme), // Pass the theme here
          ],
        ),
      ),
    );
  }


  Widget _buildTaskSummaryCard(ThemeData theme, String title, String value, TaskCategory category) {
    return InkWell(
      onTap: () => _updateCategory(category),
      child: Card(
        elevation: 4.0,
        child: Container(
          width: (title == 'Unplanned' ? 90 : 80), // Adjust width based on title
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(value, style: theme.textTheme.headline6),
              SizedBox(height: 8.0),
              Text(title, style: theme.textTheme.subtitle1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCards(BuildContext context, ThemeData theme) { // Accept `theme` as a parameter
    switch (_selectedCategory) {
      case TaskCategory.todo:
        return TodoTasks(theme: theme); // Use the passed `theme`
      case TaskCategory.overdue:
        return OverdueTasks(theme: theme); // Use the passed `theme`
      case TaskCategory.unplanned:
        return UnplannedTasks(theme: theme); // Use the passed `theme`
      default:
        return Container();
    }
  }
}