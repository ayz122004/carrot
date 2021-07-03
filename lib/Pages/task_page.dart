import 'package:flutter/material.dart';
import 'package:hackathon/Pages/item_page.dart';
import 'package:hackathon/task_item.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<TaskItem> _taskItemList = [];
  final _controller = TextEditingController();

  void _listener(TaskItem item) {
    int _index = _taskItemList.indexOf(item);
    // //remove gd from gdList
    // _gdList.remove(_gdList[_index]);
    // //rebuild GD from TI data
    // _buildTask(_taskItemList[_index]);

    //reorder _taskItemList
    TaskItem _temp = item;
    _taskItemList.remove(item);
    setState(() {
      _taskItemList.insert(_index, _temp);
    });

    print(_taskItemList);
  }

  void _addTaskItem(String title) {
    //add to _taskItemList
    TaskItem _item = TaskItem(title);
    setState(() {
      _taskItemList.add(_item);
    });
    _item.addListener(() {
      _listener(_item);
    });
    _controller.clear;
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
    final TaskItem item = _taskItemList.removeAt(oldIndex);
    _taskItemList.insert(newIndex, item);
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
          for (int index = 0; index < _taskItemList.length; index++)
            GestureDetector(
              key: Key('$index'),
              onTap: () {
                _openTask(_taskItemList[index]);
              },
              child: ListTile(
                title: Text(_taskItemList[index].getTaskTitle()),
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
