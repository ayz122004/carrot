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
        colorScheme: const ColorScheme(
          primary: Color(0xfff77156),
          primaryVariant: Color(0xffbf402c),
          onPrimary: Color(0xff000000),
          secondary: Color(0xff81c784),
          secondaryVariant: Color(0xff519657),
          onSecondary: Color(0xff472f2d),
          background: Color(0xffd9f8f2),
          error: Color(0xffeeeeee),
          surface: Color(0xffeceff1),
          onError: Color(0xfffffbfa),
          brightness: Brightness.light,
          onBackground: Color(0xffffffff),
          onSurface: Color(0xff000000),

        ),
        // primaryColor: const Color(0xfff77156),
        // accentColor: const Color(0xff81c784),
      ),
      home: Home(),
    );
  }
}
