import 'package:flutter/material.dart';
import 'package:hackathon/task_item.dart';

class ItemPage extends StatefulWidget {
  final TaskItem item;
  const ItemPage({Key? key, required this.item}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late TextEditingController _taskTitleController;
  late TextEditingController _taskDescController;
  late TextEditingController _rewardTitleController;
  late TextEditingController _rewardDescController;
  //TODO: edit item functionality

  @override
  Widget build(BuildContext context) {
    _taskTitleController = TextEditingController(text: widget.item.taskTitle);
    _taskDescController = TextEditingController(text: widget.item.taskDescription);
    _rewardTitleController = TextEditingController(text: widget.item.rewardTitle);
    _rewardDescController = TextEditingController(text: widget.item.rewardDescription);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Page"),
        actions: const [
          IconButton(
            onPressed: null, //edit item
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text("task title: "),
              SizedBox(
                width: 128,
                child: TextField(
                  controller: _taskTitleController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("task description: "),
              SizedBox(
                width: 128,
                child: TextField(
                  controller: _taskDescController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("reward title: "),
              SizedBox(
                width: 128,
                child: TextField(
                  controller: _rewardTitleController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("reward description: "),
              SizedBox(
                width: 128,
                child: TextField(
                  controller: _rewardDescController,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("complete: ${widget.item.isCompleted}"),
            ],
          ),
        ],
      ),
    );
  }
}
