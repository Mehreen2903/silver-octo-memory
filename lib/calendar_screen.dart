import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Define the custom colors
  static const Color primaryColor = Color(0xFF6750A4); // Your primary color
  static const Color secondaryColor = Color(0xFF8469B0); // Your secondary color
  static const Color tertiaryColor = Color(0xFF7D5260); // Your tertiary color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: primaryColor, // Updated to your primary color
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: secondaryColor, // Updated to your secondary color
            shape: BoxShape.circle,
          ),
          weekendTextStyle: TextStyle(color: tertiaryColor), // Updated to your tertiary color
          holidayTextStyle: TextStyle(color: tertiaryColor), // Updated to your tertiary color
        ),
      ),
    );
  }
}
