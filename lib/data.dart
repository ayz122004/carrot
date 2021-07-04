import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/task_item.dart';
import 'package:flutter/material.dart';

class MyData with ChangeNotifier {
  MyData({
    required this.tiList,
  });

  final List<TaskItem> tiList;

  void completeItem(TaskItem item) {
    tiList[tiList.indexOf(item)].setIsComplete();
    notifyListeners();
    Fluttertoast.showToast(msg: "task completed!");
  }

  void addItem(TaskItem item) {
    tiList.add(item);
    notifyListeners();
    Fluttertoast.showToast(msg: "task added!");
  }

  void update() {
    notifyListeners();
    print("update called");
  }
}