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

  void _listener() {

  }
  
  void _addTaskItem(String title) {
    TaskItem _item = TaskItem(title);
    _tiList.add(_item);
    _item.addListener(() {
      _listener();
    });
  }

  // TODO: fix this so title gets updated when edited in ItemPage
  Widget _buildTaskItem(String title) {
    
    ListTile _tile = ListTile(title: Text(_item.getTaskTitle()));

    GestureDetector _gd = GestureDetector(
      onTap: () {
        _openTask(_item);
      },
      child: _tile,
      key: ValueKey('$_counter'),
    );

    setState(() {
      _taskList.add(_gd);
    });
     _textEditingController.clear; //TODO: doesn't work
    _counter++;

    void _listener() {
      int _index = _taskList.indexOf(_gd);
      _taskList.remove(_gd);
      ListTile _newTile = ListTile(title: Text(_item.getTaskTitle()));
      GestureDetector _newGd = GestureDetector(
        onTap: () {
          _openTask(_item);
        },
        child: _newTile,
        key: ValueKey(title + '$_counter'),
      );
      setState(() {
        _taskList.insert(_index, _newGd);
      });
      _counter++;
    }

    _item.addListener(_listener);

    return _gd;
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
