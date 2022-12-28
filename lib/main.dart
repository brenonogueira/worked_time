import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                          ElevatedButton(
                            onPressed: () async {
                              List<DateTime>? dateTimeList =
                                  await showOmniDateTimeRangePicker(
                                context: context,
                                primaryColor: Colors.cyan,
                                backgroundColor: Colors.grey[900],
                                calendarTextColor: Colors.white,
                                tabTextColor: Colors.white,
                                unselectedTabBackgroundColor: Colors.grey[700],
                                buttonTextColor: Colors.white,
                                timeSpinnerTextStyle: const TextStyle(
                                    color: Colors.white70, fontSize: 18),
                                timeSpinnerHighlightedTextStyle: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                                is24HourMode: true,
                                isShowSeconds: false,
                                startInitialDate: DateTime.now(),
                                startFirstDate: DateTime(1600)
                                    .subtract(const Duration(days: 3652)),
                                startLastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                endInitialDate: DateTime.now(),
                                endFirstDate: DateTime(1600)
                                    .subtract(const Duration(days: 3652)),
                                endLastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                borderRadius: const Radius.circular(16),
                              );
                              this.dates = dateTimeList;
                              // print(dates);
                              toggle(dates);
                              setState(() {});
                            },
                            child:
                                const Text("clock in / clock out before lunch"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
														children: [
															Padding(
															  padding: const EdgeInsets.all(5.0),
															  child: Text(dates != null ? 'clock in : ${DateFormat('HH:mm').format(dates![0])}' : '',),
															),
                            	Padding(
                            	  padding: const EdgeInsets.all(5.0),
                            	  child: Text(dates != null ? 'clock out: ${DateFormat('HH:mm').format(dates![1])}' : ''),
                            	),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Worked hours:'),
                            ),
                              Text( '${workedHour1}h:${workedMinute1}m', style: const TextStyle(fontSize: 25)),
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
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
                                context: context,
                                is24HourMode: true,
                                isShowSeconds: false,
                                startInitialDate: DateTime.now(),
                                startFirstDate: DateTime(1600)
                                    .subtract(const Duration(days: 3652)),
                                startLastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                              );
                              //  dates2 = dateTimeList2;
                              // print(dates);
                              startTimeAfteLunch = dateTime;
                              toggle2(null, dateTime);
                              setState(() {});
                            },
                            child: const Text("clock in after lunch"),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       height: MediaQuery.of(context).size.height / 2,
              //       child: Column(
              //         children: [
              //           ElevatedButton(
              //             onPressed: () async {
              //               List<DateTime>? dateTimeList2 =
              //                   await showOmniDateTimeRangePicker(
              //                 context: context,
              //                 primaryColor: Colors.cyan,
              //                 backgroundColor: Colors.grey[900],
              //                 calendarTextColor: Colors.white,
              //                 tabTextColor: Colors.white,
              //                 unselectedTabBackgroundColor: Colors.grey[700],
              //                 buttonTextColor: Colors.white,
              //                 timeSpinnerTextStyle: const TextStyle(
              //                     color: Colors.white70, fontSize: 18),
              //                 timeSpinnerHighlightedTextStyle: const TextStyle(
              //                     color: Colors.white, fontSize: 24),
              //                 is24HourMode: true,
              //                 isShowSeconds: false,
              //                 startInitialDate: DateTime.now(),
              //                 startFirstDate: DateTime(1600)
              //                     .subtract(const Duration(days: 3652)),
              //                 startLastDate: DateTime.now().add(
              //                   const Duration(days: 3652),
              //                 ),
              //                 endInitialDate: DateTime.now(),
              //                 endFirstDate: DateTime(1600)
              //                     .subtract(const Duration(days: 3652)),
              //                 endLastDate: DateTime.now().add(
              //                   const Duration(days: 3652),
              //                 ),
              //                 borderRadius: const Radius.circular(16),
              //               );
              //               dates2 = dateTimeList2;
              //               // print(dates);
              //               toggle2(dates2, null);
              //               setState(() {});
              //             },
              //             child: const Text("Entrada / Saída"),
              //           ),
              //           Text(dates2 != null
              //               ? 'Entrada 1: ${dates2![0].toString().split(' ')[1].split('.')[0]}'
              //               : ''),
              //           Text(dates2 != null
              //               ? 'Saída 1: ${dates2![1].toString().split(' ')[1].split('.')[0]}'
              //               : ''),
              //           Text(
              //               'Horas trabalhadas:  ${workedHour2}h${workedMinute2}m')
              //         ],
              //       ),
              //     ),
              //   ],
              // )
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

      //hora:minuto trabalhados intervalo 1
      diffTime1 = DateTime(workedDt2!.year, workedDt2!.month, workedDt2!.day,
          workedHour1, workedMinute1);
    }
  }

  void toggle2(List<DateTime>? datesList, DateTime? startTimeAfteLunchParam) {
    if (datesList != null) {
      worked2Dt1 = datesList[0];
      worked2Dt2 = datesList[1];
      Duration difference = worked2Dt2!.difference(worked2Dt1!);

      workedHour2 = difference.inHours % 24;
      workedMinute2 = difference.inMinutes % 60;

      //hora:minuto trabalhados intervalo 2
      // TimeOfDay teste = TimeOfDay.fromDateTime(diffTime1!.add(Duration(hours: workedHour2, minutes: workedMinute2)));
      // TimeOfDay teste2 = TimeOfDay.fromDateTime(diffTime1!.(Duration(hours: workedHour2, minutes: workedMinute2)));
    } else if(startTimeAfteLunchParam != null) {
			// Hora DIMINUIR O TOTAL DE HORAS NECESSÁRIAS (8h17m) - Total do intervalo 1 de horas trabalhadas
    DateTime? neededHours = DateTime(startTimeAfteLunchParam.year, startTimeAfteLunchParam.month, startTimeAfteLunchParam.day, 8, 17);

    Duration diffNeeded = neededHours.difference(diffTime1!);

    //get Hour:Minute diff needed
    int hourdiffNeeded = diffNeeded.inHours % 24;
    int minuteDiffNeed = diffNeeded.inMinutes % 60;

    //add hourdiffNeeded and minutediffNeeded to Worked 2 Hour
    finishWorkedTime = TimeOfDay.fromDateTime(startTimeAfteLunchParam.add(Duration(hours: hourdiffNeeded, minutes: minuteDiffNeed)));
		}
  }
}
