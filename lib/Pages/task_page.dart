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
        centerTitle: true,
        backgroundColor: Colors.teal[800],
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
                  title: Text("Task: ${myData.tiList[index].getTaskTitle()}"),
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
