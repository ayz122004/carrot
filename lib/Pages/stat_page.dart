import 'package:flutter/material.dart';

class StatPage extends StatefulWidget {
  const StatPage({ Key? key }) : super(key: key);

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats Page"),
      ),
      body: Container(
        child: Text("under construction"),
      ),
    );
  }
}