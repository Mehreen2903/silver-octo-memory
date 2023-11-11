import 'package:flutter/material.dart';

class CustomFAB2 extends StatefulWidget {
  @override
  _CustomFAB2State createState() => _CustomFAB2State();
}

class _CustomFAB2State extends State<CustomFAB2> {
  void _showBottomSheetOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          // Keep padding at the top of the container
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // This will keep the content to a minimum size
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.looks_one_rounded),
                title: Text('New Non-Goal Task'),
                onTap: () {
                  // Handle the "New Non-Goal Task" action
                  Navigator.pop(context);
                },
              ),
            ],
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
