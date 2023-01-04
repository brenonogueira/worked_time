import 'package:flutter/material.dart';
import 'package:worked_time/pages/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Worked Time',
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      // '/second': (context) => const SecondScreen(),
    },
  ));
}
