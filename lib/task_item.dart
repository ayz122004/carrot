import 'package:flutter/material.dart';

class TaskItem with ChangeNotifier {
  bool isComplete = false;
  String taskTitle;
  String taskDesc;
  String rewardTitle;
  String rewardDesc;
  DateTime startBy = DateTime.now();
  DateTime endBy = DateTime.now();
  Duration timeSpent = const Duration(hours: 0, minutes: 0);
  late DateTime completionDate = DateTime.now();

  TaskItem({
    required this.taskTitle,
    required this.taskDesc,
    required this.rewardTitle,
    required this.rewardDesc,
    required this.startBy,
    required this.endBy,
  });

  String getTaskTitle() => taskTitle;
  void setTaskTitle(String title) {
    taskTitle = title;
    notifyListeners();
  }

  String getTaskDesc() => taskDesc;
  void setTaskDesc(String description) {
    taskDesc = description;
    notifyListeners();
  }

  bool getIsComplete() => isComplete;
  void setIsComplete() {
    isComplete = true;
    setCompletionDate(DateTime.now());
    notifyListeners();
  }

  String getRewardTitle() => rewardTitle;
  void setRewardTitle(String title) {
    rewardTitle = title;
    notifyListeners();
  }

  String getRewardDesc() => rewardDesc;
  void setRewardDesc(String description) {
    rewardDesc = description;
    notifyListeners();
  }

  DateTime getStartBy() => startBy;
  void setStartBy(DateTime time) {
    startBy = time;
    notifyListeners();
  }

  DateTime getEndBy() => endBy;
  void setEndBy(DateTime time) {
    endBy = time;
    notifyListeners();
  }

  Duration getTimeSpent() => timeSpent;
  void addTimeSpent(Duration time) {
    timeSpent += time;
    notifyListeners();
  }

  void setTimeSpent(Duration time) {
    timeSpent = time;
    notifyListeners();
  }

  DateTime getCompletionDate() => completionDate;
  void setCompletionDate(DateTime date) {
    completionDate = date;
    notifyListeners();
  }

  @override
  String toString() {
    return taskTitle;
  }
}
