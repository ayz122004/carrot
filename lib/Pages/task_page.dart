import 'package:flutter/material.dart';
import 'package:hackathon/Pages/item_page.dart';
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
    TaskItem _item = TaskItem(str);
    ListTile _tile = ListTile(
      title: Text(_item.taskTitle),
    );

    GestureDetector _gd = GestureDetector(
      onTap: () {
        _openTask(_item);
      },
      child: _tile,
      key: ValueKey(str + '$_counter'),
    );

    setState(() {
      _taskList.add(_gd);
    });

    //TODO: make this work
    _textEditingController.clear;
    _counter++;
    return _gd;
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

  void _reorderTaskList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Widget item = _taskList.removeAt(oldIndex);
    _taskList.insert(newIndex, item);
  }

  void _openTask(TaskItem item) {
    //open a page to the specific item
    print("openTask: ${item.taskTitle}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemPage(item: item)),
    );
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
            _reorderTaskList(oldIndex, newIndex);
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
