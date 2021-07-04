import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        centerTitle: true,
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
              children: [
                bC(),
                const Text("monthly graph here"),
                const Text("yearly graph here"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bC() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 8,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'R';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'N';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                  y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                  y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                  y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                  y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                  y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                  y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          ),
        ],
      ),
    );
  }
}
