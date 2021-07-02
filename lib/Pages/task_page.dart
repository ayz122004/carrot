import 'package:flutter/material.dart';
import 'package:hackathon/task_item.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  static int _counter = 0;

  final List<Widget> _taskList = [];
  final TextEditingController _textEditingController = TextEditingController();

  Widget _buildTaskItem(String str) {
    TaskItem item = TaskItem(str);
    ListTile tile = ListTile(
      title: Text(item.taskTitle),
      key: ValueKey(str + '$_counter'), //i hope this is right
    );
    setState(() {
      _taskList.add(tile);
    });
    //TODO: make this work
    _textEditingController.clear;
    _counter++;
    return tile;
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

  void _updateTaskList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Widget item = _taskList.removeAt(oldIndex);
    _taskList.insert(newIndex, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Page"),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            _updateTaskList(oldIndex, newIndex);
          });
        },
        children: _taskList,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }
}
