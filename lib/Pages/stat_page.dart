import 'package:flutter/material.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats Page"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: "Week"),
            Tab(text: "Month"),
            Tab(text: "Year"),
          ],
        ),
      ),
      body: TabBarView(
        //TODO: @ANGELINA custom scroll view for progress bar
        controller: _tabController,
        children: const [
          Center(child: Text("weekly graph here")),
          Center(child: Text("monthly graph here")),
          Center(child: Text("yearly graph here")),
        ],
      ),
    );
  }
}
