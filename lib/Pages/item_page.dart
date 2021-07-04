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
  late TextEditingController _taskTitleController;
  late TextEditingController _taskDescController;
  late TextEditingController _rewardTitleController;
  late TextEditingController _rewardDescController;
  late TextEditingController _startByController;
  late TextEditingController _endByController;
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;

  @override
  Widget build(BuildContext context) {
    final myData = context.watch<MyData>();

    void _deleteItem() {
      myData.tiList.remove(widget.item);
      myData.update();
      Fluttertoast.showToast(msg: "task deleted!");
      Navigator.of(context).pop();
    }

    _taskTitleController =
        TextEditingController(text: widget.item.getTaskTitle());
    _taskDescController =
        TextEditingController(text: widget.item.getTaskDesc());
    _rewardTitleController =
        TextEditingController(text: widget.item.getRewardTitle());
    _rewardDescController =
        TextEditingController(text: widget.item.getRewardDesc());
    _startByController =
        TextEditingController(text: widget.item.getStartBy().toString());
    _endByController =
        TextEditingController(text: widget.item.getEndBy().toIso8601String());
    _hoursController = TextEditingController(
        text: ((widget.item.getTimeSpent().inMinutes / 60).round()).toString());
    _minutesController = TextEditingController(
        text: (widget.item.getTimeSpent().inMinutes % 60).toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: const Text("Item Page"),
      ),
      //TODO: @ANGELINA customize body based on completion status
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue[50],
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text("Task Title: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _taskTitleController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.setTaskTitle(_taskTitleController.text);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue[100],
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text("Task Description: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _taskDescController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.setTaskDesc(_taskDescController.text);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue[200],
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text("Reward Title: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _rewardTitleController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.setRewardTitle(_rewardTitleController.text);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue[300],
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text("Reward Description: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _rewardDescController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.setRewardDesc(_rewardDescController.text);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue[400],
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text("Start By: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _startByController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.setStartBy(
                            DateTime.parse(_startByController.text));
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue,
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text("End By: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _endByController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item
                            .setEndBy(DateTime.parse(_endByController.text));
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue[600],
            padding: EdgeInsets.all(27.0),
            child: Row(
              children: [
                Text("Task Complete: ${widget.item.getIsComplete()}"),
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue[700],
            padding: EdgeInsets.all(7.0),
            child: Row(
              //TODO: @ANNA add padding/styling for row children
              children: [
                const Text("Time Spent: "),
                SizedBox(
                  width: 64,
                  child: TextFormField(
                    decoration: const InputDecoration(helperText: 'hours'),
                    controller: _hoursController,
                    readOnly: !widget.item.getIsComplete(),
                    onFieldSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.setTimeSpent(
                            Duration(hours: int.parse(_hoursController.text)));
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 64,
                  child: TextFormField(
                    decoration: const InputDecoration(helperText: 'minutes'),
                    controller: _minutesController,
                    readOnly: !widget.item.getIsComplete(),
                    onFieldSubmitted: (value) {
                      myData.update();
                      setState(() {
                        widget.item.addTimeSpent(Duration(
                            minutes: int.parse(_minutesController.text)));
                      });
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
                    //TODO: @ANNA set color based on getIsComplete()
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    widget.item.getIsComplete() ? null : _deleteItem();
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
