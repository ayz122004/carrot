import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:hackathon/Pages/item_page.dart';
import 'package:hackathon/task_item.dart';
import 'package:hackathon/data.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _controller = TextEditingController();

  void _listener(TaskItem item) {
    int _index =
        Provider.of<MyData>(context, listen: false).tiList.indexOf(item);

    TaskItem _temp = item;
    Provider.of<MyData>(context, listen: false).tiList.remove(item);
    setState(() {
      Provider.of<MyData>(context, listen: false).tiList.insert(_index, _temp);
    });

    print(Provider.of<MyData>(context, listen: false).tiList);
  }

  void _addTaskItem(String title) {
    //add to _taskItemList
    TaskItem _item = TaskItem(title);
    setState(() {
      // _taskItemList.add(_item);
      Provider.of<MyData>(context, listen: false).tiList.add(_item);
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
    final TaskItem item =
        Provider.of<MyData>(context, listen: false).tiList.removeAt(oldIndex);
    Provider.of<MyData>(context, listen: false).tiList.insert(newIndex, item);
  }

  void _openTask(TaskItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemPage(item: item)),
    );
  }

  void _completeTask(TaskItem item) {
    //TODO: what to do with completed tasks?
    item.setIsComplete();
    Fluttertoast.showToast(msg: "task completed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Page"),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (int index = 0;
              index < Provider.of<MyData>(context, listen: false).tiList.length;
              index++)
            if (Provider.of<MyData>(context, listen: false)
                    .tiList[index]
                    .getIsComplete() ==
                false)
              GestureDetector(
                key: Key('$index'),
                onTap: () {
                  _openTask(Provider.of<MyData>(context, listen: false)
                      .tiList[index]);
                },
                onHorizontalDragUpdate: (details) {
                  _completeTask(Provider.of<MyData>(context, listen: false)
                      .tiList[index]);
                },
                child: ListTile(
                  title: Text(Provider.of<MyData>(context, listen: false)
                      .tiList[index]
                      .getTaskTitle()),
                  subtitle: Text(Provider.of<MyData>(context, listen: false)
                      .tiList[index]
                      .getTaskDesc()),
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
