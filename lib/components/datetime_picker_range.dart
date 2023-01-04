import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DateTimePickerRange extends StatefulWidget {
  final List<DateTime>? dates;
  final Function(List<DateTime>?) setDates;
  final Function(List<DateTime>?) toggleDates;

  const DateTimePickerRange(
      {super.key,
      required this.setDates,
      required this.toggleDates,
      this.dates});

  @override
  State<DateTimePickerRange> createState() => _DateTimePickerRangeState();
}

class _DateTimePickerRangeState extends State<DateTimePickerRange> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
          context: context,
          primaryColor: Colors.cyan,
          backgroundColor: Colors.grey[900],
          calendarTextColor: Colors.white,
          tabTextColor: Colors.white,
          unselectedTabBackgroundColor: Colors.grey[700],
          buttonTextColor: Colors.white,
          timeSpinnerTextStyle:
              const TextStyle(color: Colors.white70, fontSize: 18),
          timeSpinnerHighlightedTextStyle:
              const TextStyle(color: Colors.white, fontSize: 24),
          is24HourMode: true,
          isShowSeconds: false,
          startInitialDate: DateTime.now(),
          startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          startLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          endInitialDate: DateTime.now(),
          endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          endLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          borderRadius: const Radius.circular(16),
        );
        widget.setDates(dateTimeList);
        widget.toggleDates(dateTimeList);
        setState(() {});
      },
      child: const Text("clock in / clock out before lunch"),
    );
  }
}
