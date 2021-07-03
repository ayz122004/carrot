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
  final List<GestureDetector> _gdList = [];
  final List<TaskItem> _tiList = [];
  final _controller = TextEditingController();

  void _listener(TaskItem item) {
    int _index = _tiList.indexOf(item);
    //rebuild GD from TI data
    _buildTask(_tiList[_index]);
    //remove gd from gdList
    _gdList.remove(_gdList[_index]);
  }

  void _addTaskItem(String title) {
    //add to _tiList
    TaskItem _item = TaskItem(title);
    _tiList.add(_item);
    _item.addListener(() {
      _listener(_item);
    });
    _buildTask(_item);
  }

  void _buildTask(TaskItem item) {
    //add to _gdList
    GestureDetector _gd = GestureDetector(
      onTap: () {
        _openTask(item);
      },
      child: ListTile(title: Text(item.getTaskTitle())),
      key: ValueKey('$_counter'),
    );
    setState(() {
      _gdList.add(_gd);
    });
     _controller.clear;
    _counter++;
  }

  Future<dynamic> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a new task"),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Enter task"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("ADD"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTaskItem(_controller.text); //TODO: change
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
    final GestureDetector gd = _gdList.removeAt(oldIndex);
    _gdList.insert(newIndex, gd);
    final TaskItem ti = _tiList.removeAt(oldIndex);
    _tiList.insert(newIndex, ti);
  }

  void _openTask(TaskItem item) {
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
        children: _gdList,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }
}
