import 'package:flutter/material.dart';

class TaskItem with ChangeNotifier {
  bool isCompleted = false;
  String _taskTitle = "default";
  String taskDescription = "default";
  String rewardTitle = "default";
  String rewardDescription = "default";

  TaskItem(this._taskTitle);

  String getTaskTitle() {
    return _taskTitle;
  }

  void setTaskTitle(String title) {
    _taskTitle = title;
    notifyListeners();
  }

  @override
  String toString() {
    // TODO: implement toString
    return _taskTitle;
  }
}
