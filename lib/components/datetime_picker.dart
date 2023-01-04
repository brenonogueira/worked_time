import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DateTimePicker extends StatefulWidget {
  final Function(DateTime?) setDate;
  final Function(List<DateTime>?, DateTime?) toggle2;

  const DateTimePicker(
      {super.key, required this.setDate, required this.toggle2});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        DateTime? dateTime = await showOmniDateTimePicker(
          context: context,
          backgroundColor: Colors.grey[900],
          calendarTextColor: Colors.white,
          tabTextColor: Colors.white,
          unselectedTabBackgroundColor: Colors.grey[700],
          buttonTextColor: Colors.white,
          is24HourMode: true,
          isShowSeconds: false,
          startInitialDate: DateTime.now(),
          startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          startLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
        );
        widget.setDate(dateTime);
        widget.toggle2(null, dateTime);
        setState(() {});
      },
      child: const Text("clock in after lunch"),
    );
  }
}
