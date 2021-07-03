import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskItem with ChangeNotifier {
  bool _isComplete = false;
  String _taskTitle = "";
  String _taskDescription = "";
  String _rewardTitle = "";
  String _rewardDescription = "";
  DateTime _startBy = DateTime.now();
  DateTime _endBy = DateTime.now();
  Duration _timeSpent = Duration(hours: 0, minutes: 0);

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

  bool getIsComplete() => _isComplete;
  void setIsComplete() {
    _isComplete = true;
    notifyListeners();
  }

  String getRewardTitle() => _rewardTitle;
  void setRewardTitle(String title) {
    _rewardTitle = title;
    notifyListeners();
  }

  String getRewardDesc() => _rewardDescription;
  void setRewardDesc(String description) {
    _rewardDescription = description;
    notifyListeners();
  }

  DateTime getStartBy() => _startBy;
  void setStartBy(DateTime time) {
    _startBy = time;
    notifyListeners();
  }

  DateTime getEndBy() => _endBy;
  void setEndBy(DateTime time) {
    _endBy = time;
    notifyListeners();
  }

  void addTimeSpent(Duration time) {
    _timeSpent += time;
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
