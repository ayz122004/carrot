import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hackathon/Pages/item_page.dart';
import 'package:hackathon/task_item.dart';
import 'package:hackathon/data.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  void _openTask(TaskItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myData = context.watch<MyData>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        title: const Text("Reward Page"),
      ),
      body: ListView(
        children: <Widget>[
          for (int index = 0; index < myData.tiList.length; index++)
            if (myData.tiList[index].getIsComplete())
              GestureDetector(
                onTap: () => _openTask(myData.tiList[index]),
                child: ListTile(
                  title:
                      Text("Reward: ${myData.tiList[index].getRewardTitle()}"),
                  subtitle: Text(
                      "Description: ${myData.tiList[index].getRewardDesc()}"),
                ),
              ),
        ],
      ),
    );
  }
}
