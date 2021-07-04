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
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Center(
              child: Text("daily progress bar here"),
              heightFactor: 8,
            ),
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 0,
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Week'),
                Tab(text: 'Month'),
                Tab(text: 'Year'),
              ],
              controller: _tabController,
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Text("weekly graph here"),
                Text("monthly graph here"),
                Text("yearly graph here"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
