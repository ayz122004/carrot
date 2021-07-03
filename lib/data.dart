import 'package:hackathon/task_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyData with ChangeNotifier{
  MyData({required this.tiList,});

  final List<TaskItem> tiList;

  void onChange() {
    notifyListeners();
    print('onchange called');
  }
  void completeItem(TaskItem item) {
    print('completeItem called');
    tiList[tiList.indexOf(item)].setIsComplete();
    notifyListeners();
    print(this.hasListeners);
  }
}