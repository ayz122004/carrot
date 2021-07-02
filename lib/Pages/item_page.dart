import 'package:flutter/material.dart';
import 'package:hackathon/task_item.dart';

class ItemPage extends StatefulWidget {
  final TaskItem item;
  const ItemPage({ Key? key, required this.item }) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.taskTitle),
      ),
      body: Text("t_desc: ${widget.item.taskDescription}, r: ${widget.item.rewardTitle}, r_desc: ${widget.item.rewardDescription}"),
    );
  }
}