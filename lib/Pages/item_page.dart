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

  void _deleteItem() {
    //TODO: add changeNotifier here - list doesn't update until listener is triggered
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
        TextEditingController(text: widget.item.rewardTitle);
    _rewardDescController =
        TextEditingController(text: widget.item.rewardDescription);

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
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.rewardTitle = _rewardTitleController.text;
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
                  onSubmitted: (value) {
                    setState(() {
                      widget.item.rewardDescription =
                          _rewardDescController.text;
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
