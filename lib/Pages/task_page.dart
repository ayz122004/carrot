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
    // //remove gd from gdList
    // _gdList.remove(_gdList[_index]);
    // //rebuild GD from TI data
    // _buildTask(_tiList[_index]);

    //reorder _tiList
    TaskItem _temp = item;
    _tiList.remove(item);
    setState(() {
      _tiList.insert(_index, _temp);
    });

    print(_tiList);
  }

  void _addTaskItem(String title) {
    //add to _tiList
    TaskItem _item = TaskItem(title);
    setState(() {
      _tiList.add(_item);
    });
    _item.addListener(() {
      _listener(_item);
    });
    //_buildTask(_item);
    _controller.clear;
  }

  // void _buildTask(TaskItem item) {
  //   //add to _gdList
  //   GestureDetector _gd = GestureDetector(
  //     onTap: () {
  //       _openTask(item);
  //     },
  //     child: ListTile(
  //       title: Text(item.getTaskTitle()),
  //       subtitle: Text(item.getTaskDesc()),
  //     ),
  //     key: ValueKey('$_counter'),
  //   );
  //   setState(() {
  //     _gdList.add(_gd);
  //   });
  //   _controller.clear;
  //   _counter++;
  // }

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
                  _controller.clear;
                  _addTaskItem(_controller.text);
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
        children: <Widget>[
          for (int index = 0; index < _tiList.length; index++)
            GestureDetector(
              key: Key('$index'),
              onTap: () {
                _openTask(_tiList[index]);
              },
              child: ListTile(
                title: Text(_tiList[index].getTaskTitle()),
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          setState(() {
            _reorderTaskList(oldIndex, newIndex);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }
}
