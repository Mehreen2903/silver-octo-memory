import 'package:flutter/material.dart';
import 'input_dialog.dart';

class CustomFAB extends StatefulWidget {
  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  void _showBottomSheetOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Set a minimum height for the container
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.3),
          child: Padding(
            // Add padding at the top of the container
            padding: const EdgeInsets.only(top: 20.0),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.pie_chart),
                  title: Text('New Area'),
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    showNewAreaDialog(context); // Open the new area input dialog
                  },
                ),
                ListTile(
                  leading: Icon(Icons.flag_circle_sharp),
                  title: Text('New Goal'),
                  onTap: () {
                    Navigator.pop(context);
                    showNewGoalDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('New Task'),
                  onTap: () {
                    // Handle the "New Task" action
                    Navigator.pop(context);
                    showNewTaskDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.repeat),
                  title: Text('New Repeating Task'),
                  onTap: () {
                    // Handle the "New Repeating Task" action
                    Navigator.pop(context);
                    showNewRepeatingTaskDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton(
      onPressed: () => _showBottomSheetOptions(context),
      backgroundColor: colorScheme.primary,
      child: Icon(Icons.add, color: colorScheme.onPrimary),
      elevation: 4.0,
      tooltip: 'Add New', // Helpful for accessibility
    );
  }
}
