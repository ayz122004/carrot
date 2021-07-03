import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Page"),
      ),
      body: ListView(
        children: <Widget>[
          for (int index = 0;
              index < Provider.of<MyData>(context, listen: false).tiList.length;
              index++)
            if (Provider.of<MyData>(context, listen: false)
                .tiList[index]
                .getIsComplete())
              GestureDetector(
                onTap: () {
                  _openTask(Provider.of<MyData>(context, listen: false)
                      .tiList[index]);
                },
                child: ListTile(
                  title: Text(
                      "Reward: ${Provider.of<MyData>(context, listen: false).tiList[index].getRewardTitle()}"),
                  subtitle: Text(
                      "Description: ${Provider.of<MyData>(context, listen: false).tiList[index].getRewardDesc()}"),
                ),
              ),
        ],
      ),
    );
  }
}
