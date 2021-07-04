import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hackathon/task_item.dart';
import 'package:hackathon/data.dart';

class CreatePage extends StatelessWidget {
  CreatePage({Key? key}) : super(key: key);

  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  final _c4 = TextEditingController();
  final _c5 = TextEditingController();
  final _c6 = TextEditingController();
  String _tt = "", _td = "", _rt = "", _rd = "";
  DateTime _sb = DateTime.now(), _eb = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final myData = context.watch<MyData>();

    void _listener(TaskItem item) {
      int _index = myData.tiList.indexOf(item);
      TaskItem _temp = item;
      myData.tiList.remove(item);
      myData.tiList.insert(_index, _temp);
    }

    void _addTaskItem() {
      TaskItem _item = TaskItem(
        taskTitle: _tt,
        taskDesc: _td,
        rewardDesc: _rd,
        rewardTitle: _rt,
        startBy: _sb,
        endBy: _eb,
      );
      myData.addItem(_item);
      _item.addListener(() {
        _listener(_item);
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Task Item"),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _c1,
              decoration: const InputDecoration(hintText: "enter task"),
              onFieldSubmitted: (value) {
                _tt = _c1.text;
              },
            ),
            TextFormField(
              controller: _c2,
              decoration: const InputDecoration(hintText: "task description"),
              onFieldSubmitted: (value) {
                _td = _c2.text;
              },
            ),
            TextFormField(
              controller: _c3,
              decoration: const InputDecoration(hintText: "enter reward"),
              onFieldSubmitted: (value) {
                _rt = _c3.text;
              },
            ),
            TextFormField(
              controller: _c4,
              decoration: const InputDecoration(hintText: "reward description"),
              onFieldSubmitted: (value) {
                _rd = _c4.text;
              },
            ),
            TextFormField(
              controller: _c5,
              decoration: const InputDecoration(hintText: "start by"),
              onFieldSubmitted: (value) {
                _sb = DateTime.parse(_c5.text);
              },
            ),
            TextFormField(
              controller: _c6,
              decoration: const InputDecoration(hintText: "finish by"),
              onFieldSubmitted: (value) {
                _eb = DateTime.parse(_c6.text);
              },
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => _addTaskItem(),
                  child: const Text("ADD"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("CANCEL"),
                ),
              ],
            ),
          ],
        ));
  }
}
