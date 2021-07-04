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
      _sbController,
      _ebController,
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
      _timeSpent = _tsHours*60 + _tsMinutes;
      setState(() {
        widget.item.setTimeSpent(Duration(minutes: _timeSpent));
      });
    }

    _ttController = TextEditingController(text: widget.item.getTaskTitle());
    _tdController = TextEditingController(text: widget.item.getTaskDesc());
    _rtController = TextEditingController(text: widget.item.getRewardTitle());
    _rdController = TextEditingController(text: widget.item.getRewardDesc());
    _sbController =
        TextEditingController(text: widget.item.getStartBy().toString());
    _ebController =
        TextEditingController(text: widget.item.getEndBy().toIso8601String());
    _hController = TextEditingController(text: _tsHours.toString());
    _mController = TextEditingController(text: _tsMinutes.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Item Page"),
      ),
      //TODO: @ANGELINA customize body based on completion status
      body: ListView(
        children: [
          Container(
            color: Colors.teal[50],
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(hintText: "Task Title"),
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
          Container(
            color: Colors.teal[100],
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(hintText: "Task Description"),
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
          Container(
            color: Colors.teal[200],
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(hintText: "Reward Title"),
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
          Container(
            color: Colors.teal[300],
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(hintText: "Reward Description"),
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
          Container(
            color: Colors.teal[400],
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration:
                  const InputDecoration(hintText: "Start By: (2000-01-01)"),
              controller: _sbController,
              readOnly: widget.item.getIsComplete(),
              onSubmitted: (value) {
                myData.update();
                setState(() {
                  widget.item.setStartBy(DateTime.parse(_sbController.text));
                });
              },
            ),
          ),
          Container(
            color: Colors.teal,
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration:
                  const InputDecoration(hintText: "End By: (2000-01-01)"),
              controller: _ebController,
              readOnly: widget.item.getIsComplete(),
              onSubmitted: (value) {
                myData.update();
                setState(() {
                  widget.item.setEndBy(DateTime.parse(_ebController.text));
                });
              },
            ),
          ),
          Container(
            color: Colors.teal[600],
            padding: const EdgeInsets.all(27.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Task Complete: ${widget.item.getIsComplete()}",
              style: const TextStyle(fontSize: 16),
            ),
          ),

          //timeSpent fields
          Container(
            color: Colors.teal[700],
            padding: const EdgeInsets.all(7.0),
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
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(12.0),
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
