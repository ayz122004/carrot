import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:hackathon/Pages/item_page.dart';
import 'package:hackathon/task_item.dart';
import 'package:hackathon/data.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
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

  void _function2(TaskItem item) {
    //to be implemented
  }

  void _renderList(TaskItem item) {
    //must call _addTaskItem to make list render
    //TODO: fix that
    if (item.getIsComplete()) {
      _addTaskItem(item.getTaskTitle());
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      //hotrestart to rebuild widget
      //TODO: setState when tiList changes
      Provider.of<MyData>(context, listen: false).tiList.isNotEmpty
        ? _renderList(Provider.of<MyData>(context, listen: false).tiList[0])
        : print('empty');
    });
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
                .getIsComplete())
              GestureDetector(
                key: Key('$index'),
                onTap: () {
                  _openTask(Provider.of<MyData>(context, listen: false)
                      .tiList[index]);
                },
                onHorizontalDragUpdate: (details) {
                  _function2(Provider.of<MyData>(context, listen: false)
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
    );
  }
}
