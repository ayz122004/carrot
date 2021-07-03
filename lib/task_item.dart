import 'package:flutter/material.dart';

class TaskItem with ChangeNotifier {
  bool isCompleted = false;
  String _taskTitle = "default";
  String _taskDescription = "default";
  String rewardTitle = "default";
  String rewardDescription = "default";

  TaskItem(this._taskTitle);

  String getTaskTitle() => _taskTitle;

  void setTaskTitle(String title) {
    _taskTitle = title;
    notifyListeners();
  }

  String getTaskDesc() => _taskDescription;
  void setTaskDesc(String description) {
    _taskDescription = description;
    notifyListeners();
  }

  void plsUpdate() {
    notifyListeners();
  }

  @override
  String toString() {
    return _taskTitle;
  }
}
