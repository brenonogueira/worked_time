import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worked_time/components/datetime_picker.dart';
import 'package:worked_time/components/datetime_picker_range.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DateTime>? dates;
  int workedHour1 = 0;
  int workedMinute1 = 0;
  DateTime? workedDt1;
  DateTime? workedDt2;
  DateTime? diffTime1;

  List<DateTime>? dates2;
  int workedHour2 = 0;
  int workedMinute2 = 0;
  DateTime? worked2Dt1;
  DateTime? worked2Dt2;
  DateTime? diffTime2;

  DateTime? startTimeAfteLunch;
  TimeOfDay? finishWorkedTime;

  void setDates(List<DateTime>? values) {
    setState(() {
      dates = values;
    });
  }

  void setDate(DateTime? value) {
    setState(() {
      startTimeAfteLunch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: 'Breno Clock In',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Breno Clock-In'))),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Column(
                        children: [
                          DateTimePickerRange(
                              setDates: setDates,
                              toggleDates: toggle,
                              dates: dates),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    dates != null
                                        ? 'clock in : ${DateFormat('HH:mm').format(dates![0])}'
                                        : '',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(dates != null
                                      ? 'clock out: ${DateFormat('HH:mm').format(dates![1])}'
                                      : ''),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Worked hours:'),
                                ),
                                Text('${workedHour1}h:${workedMinute1}m',
                                    style: const TextStyle(fontSize: 25)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          DateTimePicker(
                            setDate: setDate,
                            toggle2: toggle2,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Clock in after lunch:'),
                                ),
                                Text(
                                  startTimeAfteLunch != null
                                      ? ' ${DateFormat('HH:mm').format(startTimeAfteLunch!)}'
                                      : '',
                                  style: const TextStyle(fontSize: 25),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Time to stop working:'),
                                ),
                                Text(
                                  startTimeAfteLunch != null
                                      ? ' ${finishWorkedTime.toString().split('(')[1].split(')')[0]}'
                                      : '',
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggle(List<DateTime>? datesList) {
    if (datesList != null) {
      workedDt1 = datesList[0];
      workedDt2 = datesList[1];
      Duration difference = workedDt2!.difference(workedDt1!);

      workedHour1 = difference.inHours % 24;
      workedMinute1 = difference.inMinutes % 60;
      
      diffTime1 = DateTime(workedDt2!.year, workedDt2!.month, workedDt2!.day,
          workedHour1, workedMinute1);

      setState(() {});
    }
  }

  void toggle2(List<DateTime>? datesList, DateTime? startTimeAfteLunchParam) {
    if (datesList != null) {
      worked2Dt1 = datesList[0];
      worked2Dt2 = datesList[1];
      Duration difference = worked2Dt2!.difference(worked2Dt1!);

      workedHour2 = difference.inHours % 24;
      workedMinute2 = difference.inMinutes % 60;

      setState(() {});
    } else if (startTimeAfteLunchParam != null) {
      DateTime? neededHours = DateTime(startTimeAfteLunchParam.year,
          startTimeAfteLunchParam.month, startTimeAfteLunchParam.day, 8, 17);

      Duration diffNeeded = neededHours.difference(diffTime1!);

      int hourdiffNeeded = diffNeeded.inHours % 24;
      int minuteDiffNeed = diffNeeded.inMinutes % 60;

      finishWorkedTime = TimeOfDay.fromDateTime(startTimeAfteLunchParam
          .add(Duration(hours: hourdiffNeeded, minutes: minuteDiffNeed)));
      setState(() {});
    }
  }
}
