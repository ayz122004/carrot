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
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hackathon App",
      theme: ThemeData(
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        colorScheme: const ColorScheme(
          primary: Color(0xfff77156),
          primaryVariant: Color(0xffbf402c),
          onPrimary: Color(0xff000000),
          secondaryVariant: Color(0xff00796b),
          secondary: Color(0xff48a999),
          onSecondary: Color(0xff000000),
          background: Color(0xffd9f8f2),
          error: Color(0xffeeeeee),
          surface: Color(0xff37474f),
          onError: Color(0xff000000),
          brightness: Brightness.dark,
          onBackground: Color(0xffffffff),
          onSurface: Color(0xffffa283),

        ),        
      ),
      home: Home(),
    );
  }
}
