import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hackathon/task_item.dart';
import 'package:hackathon/data.dart';

class ItemPage extends StatefulWidget {
  final TaskItem item;
  const ItemPage({Key? key, required this.item}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late TextEditingController _ttController,
      _tdController,
      _rtController,
      _rdController,
      _hController,
      _mController;

  @override
  Widget build(BuildContext context) {
    int _timeSpent = widget.item.getTimeSpent().inMinutes;
    int _tsHours = _timeSpent ~/ 60;
    int _tsMinutes = _timeSpent % 60;
    final myData = context.watch<MyData>();

    void _deleteItem() {
      myData.tiList.remove(widget.item);
      myData.update();
      Fluttertoast.showToast(msg: "task deleted!");
      Navigator.of(context).pop();
    }

    void _updateTimeSpent() {
      myData.update();
      _timeSpent = _tsHours * 60 + _tsMinutes;
      setState(() {
        widget.item.setTimeSpent(Duration(minutes: _timeSpent));
      });
    }

    Widget _dateTimeField() {
      DateTime _dt = widget.item.getDeadline();
      String _dVal = _dt.day.toString(),
          _mVal = _dt.month.toString(),
          _yVal = _dt.year.toString(),
          _hVal = _dt.hour.toString(),
          _minVal = _dt.minute.toString();
      if (_dt.day < 10) _dVal = "0$_dVal";
      if (_dt.month < 10) _mVal = "0$_mVal";
      if (_dt.hour < 10) _hVal = "0$_hVal";
      if (_dt.minute < 10) _minVal = "0$_minVal";
      var _dText = TextEditingController(text: _dVal),
          _mText = TextEditingController(text: _mVal),
          _yText = TextEditingController(text: _yVal),
          _hText = TextEditingController(text: _hVal),
          _minText = TextEditingController(text: _minVal);

      void _update() {
        myData.update();
        String str = "$_yVal-$_mVal-$_dVal $_hVal:$_minVal";
        _dt = DateTime.parse(str);
        widget.item.setDeadline(_dt);
      }

      try {
        return Card(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(12.0),
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
                    readOnly: widget.item.getIsComplete(),
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
                    readOnly: widget.item.getIsComplete(),
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
                    readOnly: widget.item.getIsComplete(),
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
                    readOnly: widget.item.getIsComplete(),
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
                    readOnly: widget.item.getIsComplete(),
                    onFieldSubmitted: (value) {
                      _minVal = _minText.text;
                      if (_minVal.length < 2) _minVal = "0$_minVal";
                      _update();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        return const Text("error");
      }
    }

    _ttController = TextEditingController(text: widget.item.getTaskTitle());
    _tdController = TextEditingController(text: widget.item.getTaskDesc());
    _rtController = TextEditingController(text: widget.item.getRewardTitle());
    _rdController = TextEditingController(text: widget.item.getRewardDesc());
    _hController = TextEditingController(text: _tsHours.toString());
    _mController = TextEditingController(text: _tsMinutes.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Edit Task"),
      ),
      //TODO: @ANGELINA customize body based on completion status
      body: ListView(
        children: [
          Card(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Enter task title"),
                controller: _ttController,
                readOnly: widget.item.getIsComplete(),
                onSubmitted: (value) {
                  myData.update();
                  setState(() {
                    widget.item.setTaskTitle(_ttController.text);
                  });
                },
              ),
            ),
          ),
          Card(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: "Enter task description"),
                controller: _tdController,
                readOnly: widget.item.getIsComplete(),
                onSubmitted: (value) {
                  myData.update();
                  setState(() {
                    widget.item.setTaskDesc(_tdController.text);
                  });
                },
              ),
            ),
          ),
          Card(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: "Enter reward title"),
                controller: _rtController,
                readOnly: widget.item.getIsComplete(),
                onSubmitted: (value) {
                  myData.update();
                  setState(() {
                    widget.item.setRewardTitle(_rtController.text);
                  });
                },
              ),
            ),
          ),
          Card(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: "Enter reward description"),
                controller: _rdController,
                readOnly: widget.item.getIsComplete(),
                onSubmitted: (value) {
                  myData.update();
                  setState(() {
                    widget.item.setRewardDesc(_rdController.text);
                  });
                },
              ),
            ),
          ),
          _dateTimeField(),
          Card(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.fromLTRB(
                12.0,
                25.0,
                25.0,
                25.0,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "Task Complete: ${widget.item.getIsComplete()}",
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),

          //timeSpent fields
          Card(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.fromLTRB(
                12.0,
                8.0,
                8.0,
                17.0,
              ),
              child: Row(
                children: [
                  const Text("Time Spent: "),
                  SizedBox(
                    width: 64,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _hController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(suffixText: "hrs"),
                      readOnly: !widget.item.getIsComplete(),
                      onFieldSubmitted: (value) {
                        _tsHours = int.parse(_hController.text);
                        _updateTimeSpent();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 64,
                    child: TextFormField(
                      decoration: const InputDecoration(suffixText: "min"),
                      textAlign: TextAlign.center,
                      controller: _mController,
                      keyboardType: TextInputType.number,
                      readOnly: !widget.item.getIsComplete(),
                      onFieldSubmitted: (value) {
                        _tsMinutes = int.parse(_mController.text);
                        _updateTimeSpent();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.fromLTRB(
              12.0,
              15.0,
              5.0,
              20.0,
            ),
            child: Row(
              children: [
                TextButton(
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    widget.item.getIsComplete()
                        ? Fluttertoast.showToast(
                            msg: "can't delete completed tasks")
                        : _deleteItem();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
