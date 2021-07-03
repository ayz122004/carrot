import 'package:flutter/material.dart';
import 'package:hackathon/Pages/task_page.dart';
import 'package:hackathon/Pages/reward_page.dart';
import 'package:hackathon/Pages/stat_page.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
      index: _pageIndex,
      children: const [
        TaskPage(),
        RewardPage(),
        StatPage(),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _pageIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Reward',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Stats',
          ),
      ],
    ),

    );
    
    
  }
}