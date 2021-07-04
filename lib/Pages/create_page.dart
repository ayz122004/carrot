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
  String _tt = "", _td = "", _rt = "", _rd = "";
  DateTime _dl = DateTime.now();

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
        deadline: _dl,
      );
      myData.addItem(_item);
      _item.addListener(() {
        _listener(_item);
      });
      Navigator.of(context).pop();
    }

    Widget _dateTimeField() {
      DateTime _dt = DateTime.now();
      String _dVal = _dt.day.toString(),
          _mVal = _dt.month.toString(),
          _yVal = _dt.year.toString(),
          _hVal = _dt.hour.toString(),
          _minVal = _dt.minute.toString();
      if (_dt.day < 10) _dVal = "0$_dVal";
      if (_dt.month < 10) _mVal = "0$_mVal";
      if (_dt.hour < 10) _hVal = "0$_hVal";
      if (_dt.minute < 10) _minVal = "0$_minVal";
      var _dText = TextEditingController(text: _dl.day.toString()),
          _mText = TextEditingController(text: _dl.month.toString()),
          _yText = TextEditingController(text: _dl.year.toString()),
          _hText = TextEditingController(text: _dl.hour.toString()),
          _minText = TextEditingController(text: _dl.minute.toString());
      
      void _update() {
        String str = "$_yVal-$_mVal-$_dVal $_hVal:$_minVal";
        _dt = DateTime.parse(str);
        _dl = _dt;
      }

      try {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text("Deadline: "),

              //Date
              SizedBox(
                width: 32,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _dText,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "DD"),
                  onFieldSubmitted: (value) {
                    _dVal = _dText.text;
                    if (_dVal.length < 2) _dVal = "0$_dVal";
                    _update();
                  },
                ),
              ),

              //Month
              SizedBox(
                width: 32,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _mText,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "MM"),
                  onFieldSubmitted: (value) {
                    _mVal = _mText.text;
                    if (_mVal.length < 2) _mVal = "0$_mVal";
                    _update();
                  },
                ),
              ),

              //Year
              SizedBox(
                width: 64,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _yText,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "YYYY"),
                  onFieldSubmitted: (value) {
                    _yVal = _yText.text;
                    _update();
                  },
                ),
              ),
              //Hour
              SizedBox(
                width: 32,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _hText,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "hh"),
                  onFieldSubmitted: (value) {
                    _hVal = _hText.text;
                    if (_hVal.length < 2) _hVal = "0$_hVal";
                    _update();
                  },
                ),
              ),

              //Minute
              SizedBox(
                width: 32,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _minText,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "mm"),
                  onFieldSubmitted: (value) {
                    _minVal = _minText.text;
                    if (_minVal.length < 2) _minVal = "0$_minVal";
                    _update();
                  },
                ),
              ),
            ],
          ),
        );
      } catch (e) {
        return const Text("error");
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[700],
          centerTitle: true,
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
            _dateTimeField(),
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
