import 'package:flutter/material.dart';
import 'package:new_todo_app/widgets/home_screen.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todayTasksBox');
  await Hive.openBox('tomorrowTasksBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Todo App',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
