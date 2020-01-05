import 'package:flutter/material.dart';

//Screens
import 'screens/pomodoroScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro App',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.transparent,
        primaryColor: Colors.green,
        fontFamily: 'Ubuntu',
      ),
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.red,
      ),
      home: PomodoroScreen(),
    );
  }
}
