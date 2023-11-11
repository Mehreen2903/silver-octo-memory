import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'home_screen.dart';
import 'fab_1.dart'; // Import the CustomFAB widget for the floating action button
import 'fab_2.dart'; // Import your CustomFAB2 widget for the floating action button
import 'fab_3.dart'; // Import your CustomFAB3 widget for the floating action button

class BaseScreen extends StatefulWidget {
  final Function(bool) toggleTheme;

  BaseScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool isDarkTheme = false;
  int _selectedIndex = 0;

  static const List<String> _tabTitles = [
    'Home',
    'Areas',
    'SA Tasks',
    'Reflections',
  ];

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(toggleTheme: widget.toggleTheme);
      case 1:
      // return AreaScreen(); // Uncomment once you have this screen implemented
        return Placeholder(); // Placeholder widget until the real one is implemented
      case 2:
      // return SATasksScreen(); // Uncomment once you have this screen implemented
        return Placeholder(); // Placeholder widget until the real one is implemented
      case 3:
      // return ReflectionsScreen(); // Uncomment once you have this screen implemented
        return Placeholder(); // Placeholder widget until the real one is implemented
      default:
        return HomeScreen(toggleTheme: widget.toggleTheme);
    }
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedIndex) {
      case 0:
      case 1:
        return CustomFAB(); // This is your FAB from fab_1.dart for tabs 0 and 1
      case 2:
        return CustomFAB2(); // You would return the FAB for tab 2 here

      case 3:
        return CustomFAB3(); // You would return the FAB for tab 3 here

      default:
        return SizedBox(); // Returns an empty container when no FAB should be shown
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tabTitles[_selectedIndex],
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: colorScheme.onPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: Text('Settings', style: TextStyle(color: colorScheme.onPrimary)),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  isDarkTheme = value;
                });
                widget.toggleTheme(value);
              },
            ),
            // ... other drawer items
          ],
        ),
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.60),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Areas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'SA Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Reflections',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: _buildFloatingActionButton(), // Add this line
    );
  }
}
