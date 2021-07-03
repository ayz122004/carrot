import 'package:flutter/material.dart';
import 'package:hackathon/home.dart';
import 'package:hackathon/data.dart';
import 'package:hackathon/task_item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MyData(tiList: <TaskItem>[]),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Hackathon App",
      home: Home(),
    );
  }
}