import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Widget> _taskList = [];
  final TextEditingController _textEditingController = TextEditingController();

  Widget _buildTaskItem(String str) {
    ListTile item = ListTile(title: Text(str));
    setState(() {
      _taskList.add(item);
    });
    //TODO: make this work
    _textEditingController.clear; 
    return item;
  }

  Future<dynamic> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a new task"),
            content: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: "Enter task"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("ADD"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _buildTaskItem(_textEditingController.text);
                },
              ),
              TextButton(
                child: const Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Page"),
      ),
      body: ListView(
        children: _taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>  _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
      );
  }
}
