import 'package:flutter/material.dart';
import 'package:flutter_application_1/sql_details/regestrationscreen.dart';
import 'package:flutter_application_1/welcomescreen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
await Hive.initFlutter();

await Hive.openBox('db');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:WelcomeScreen(),
    );
  }
}
