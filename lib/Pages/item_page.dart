import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

  void _deleteItem() {
    //TODO: add changeNotifier to tiList - list doesn't update until listener is triggered
    Provider.of<MyData>(context, listen: false).tiList.remove(widget.item);
    Provider.of<MyData>(context, listen: false).tiList[0].plsUpdate(); //h4ck3r
    Fluttertoast.showToast(msg: "task deleted!");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
    final _hoursController = TextEditingController();
    final _minutesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Page"),
        actions: const [
          IconButton(
            onPressed: null, //edit item
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text("task title: "),
                SizedBox(
                  width: 256,
                  child: TextField(
                    controller: _taskTitleController,
                    readOnly: widget.item.getIsComplete(),
                    onSubmitted: (value) {
                      setState(() {
                        widget.item.setTaskTitle(_taskTitleController.text);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              const Text("task description: "),
              SizedBox(
                width: 256,
                child: TextField(
                  controller: _taskDescController,
                  readOnly: widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.setTaskDesc(_taskDescController.text);
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("reward title: "),
              SizedBox(
                width: 256,
                child: TextField(
                  controller: _rewardTitleController,
                  readOnly: widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.setRewardTitle(_rewardTitleController.text);
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("reward description: "),
              SizedBox(
                width: 256,
                child: TextField(
                  controller: _rewardDescController,
                  readOnly: widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.setRewardDesc(_rewardDescController.text);
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("start by: "),
              SizedBox(
                width: 256,
                child: TextField(
                  controller: _startByController,
                  readOnly: widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.setStartBy(DateTime.parse(_startByController.text));
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("end by: "),
              SizedBox(
                width: 256,
                child: TextField(
                  controller: _endByController,
                  readOnly: widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.setEndBy(DateTime.parse(_endByController.text));
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("complete: ${widget.item.getIsComplete()}"),
            ],
          ),
          Row(
            children: [
              const Text("Hours: "),
              SizedBox(
                width: 128,
                child: TextField(
                  controller: _hoursController,
                  readOnly: !widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.addTimeSpent(Duration(hours: int.parse(_hoursController.text)));
                    });
                  },
                ),
              ),
              const Text("Minutes: "),
              SizedBox(
                width: 128,
                child: TextField(
                  controller: _minutesController,
                  readOnly: !widget.item.getIsComplete(),
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.addTimeSpent(Duration(minutes: int.parse(_minutesController.text)));
                    });
                  },
                ),
              ),
            ],
          ),
          TextButton(
            child: const Text(
              "Delete",
              //TODO: set color based on getIsComplete()
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              widget.item.getIsComplete() ? null : _deleteItem();
            },
          ),
        ],
      ),
    );
  }
}
