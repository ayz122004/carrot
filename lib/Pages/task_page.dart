import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hackathon/Pages/item_page.dart';
import 'package:hackathon/Pages/create_page.dart';
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

  Future<dynamic> _createDialog(BuildContext context) async {
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

  void _createTask() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => CreatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myData = context.watch<MyData>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Page"),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (int index = 0; index < myData.tiList.length; index++)
            if (myData.tiList[index].getIsComplete() == false)
              GestureDetector(
                key: Key('$index'),
                onTap: () {
                  _openTask(myData.tiList[index]);
                },
                onHorizontalDragUpdate: (details) {
                  myData.completeItem(myData.tiList[index]);
                },
                child: ListTile(
                  title: Text(
                      "Task: ${myData.tiList[index].getTaskTitle()}"),
                  subtitle: Text(
                      "Description: ${myData.tiList[index].getTaskDesc()}"),
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
          onPressed: () => _createTask(),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }
}
