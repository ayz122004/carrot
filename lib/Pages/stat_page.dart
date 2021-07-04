import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:hackathon/data.dart';

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
    /*RETRIEVE DATA FROM TILIST FOR CHARTS*/

    final myData = context.watch<MyData>();
    DateTime today = DateTime.now();

    // set future dates/times' default values to 0
    var dayList = List.filled(2, 0);
    var weekList = List.filled(7, 0);
    var monthList = List.filled(31, 0);
    var yearList = List.filled(12, 0);

    // daily: completed/total TaskItems in list
    void getDayList() {
      dayList.fillRange(0, 2, 0);
      for (int i = 0; i < myData.tiList.length; i++) {
        if (myData.tiList[i].deadline.day == today.day) {
          if (myData.tiList[i].isComplete) dayList[0]++;
          dayList[1]++;
        }
      }
    }

    // weekly: list of 7 ints, tasks from this week, completionDate.weedday
    void getWeekList() {
      weekList.fillRange(0, 7, 0);
      int lower = today.day - today.weekday; //first date of the week
      int upper = today.day - today.weekday + 7; //last date of the week
      for (int i = 0; i < myData.tiList.length; i++) {
        if (myData.tiList[i].completionDate.day > lower &&
            myData.tiList[i].completionDate.day <= upper) {
          weekList[today.weekday - 1] += myData.tiList[i].timeSpent.inMinutes;
        }
      }
    }

    // monthly: list of 28-31 ints, tasks from this month, sorted by completionDate.day
    void getMonthList() {
      monthList.fillRange(0, 31, 0);
      for (int i = 0; i < myData.tiList.length; i++) {
        if (myData.tiList[i].completionDate.month == today.month) {
          monthList[today.day - 1] += myData.tiList[i].timeSpent.inMinutes;
        }
      }
    }

    // yearly: list of 12 ints, tasks from this year, sorted by completionDate.month
    void getYearList() {
      yearList.fillRange(0, 12, 0);
      for (int i = 0; i < myData.tiList.length; i++) {
        if (myData.tiList[i].completionDate.year == today.year) {
          yearList[today.month - 1] += myData.tiList[i].timeSpent.inMinutes;
        }
      }
    }

    Widget progressBar() {
      getDayList();
      if (dayList[1] == 0) {
        //prevent zero division exception
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("no tasks today"),
        );
      }
      return AspectRatio(
        aspectRatio: 4,
        child: RotatedBox(
          quarterTurns: 1,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100, 
                axisTitleData: FlAxisTitleData(
                  show: true,
                  leftTitle: AxisTitle(
                    showTitle: true,
                    titleText: "Daily Progress Bar",
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(showTitles: false),
                  leftTitles: SideTitles(showTitles: false),
                  rightTitles: SideTitles(
                    rotateAngle: 270,
                    showTitles: true,
                    margin: 20,
                    getTitles: (double value) {
                      if (value % 25 == 0) return value.toInt().toString();
                      return "";
                    },
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                          y: dayList[0] / dayList[1] * 100,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget weekChart() {
      //TODO: @ANY add y axis label (Hours)
      getWeekList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 24,
            titlesData: FlTitlesData(
              show: true,
              leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (double value) {
                    if (value.toInt().isEven) return value.toInt().toString();
                    return "";
                  }
                  //margin: 20;
                  ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  List<String> _weekdays = [
                    "Mon",
                    "Tue",
                    "Wed",
                    "Thu",
                    "Fri",
                    "Sat",
                    "Sun"
                  ];
                  return _weekdays[value.toInt()];
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              for (int i = 0; i < 7; i++)
                BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                        y: (weekList[i] / 60),
                        colors: [Colors.lightBlueAccent, Colors.greenAccent])
                  ],
                ),
            ],
          ),
        ),
      );
    }

    Widget monthChart() {
      //TODO: @ANY make this chart sideways
      getMonthList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 24,
            titlesData: FlTitlesData(
              show: true,
              leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (double value) {
                    if (value.toInt().isEven) return value.toInt().toString();
                    return "";
                  }
                  //margin: 20;
                  ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  return (value + 1).toInt().toString();
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              for (int i = 0; i < 31; i++)
                BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                        y: (monthList[i] / 60),
                        colors: [Colors.lightBlueAccent, Colors.greenAccent])
                  ],
                ),
            ],
          ),
        ),
      );
    }

    Widget yearChart() {
      getYearList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 24,
            titlesData: FlTitlesData(
              show: true,
              leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (double value) {
                    return value.toString();
                  }
                  //margin: 20;
                  ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  List<String> _months = [
                    "Jan",
                    "Feb",
                    "Mar",
                    "Apr",
                    "May",
                    "Jun",
                    "Jul",
                    "Aug",
                    "Sep",
                    "Oct",
                    "Nov",
                    "Dec",
                  ];
                  return _months[value.toInt()];
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              for (int i = 0; i < 12; i++)
                BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                        y: (yearList[i] / 60),
                        colors: [Colors.lightBlueAccent, Colors.greenAccent])
                  ],
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats Page"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: progressBar(),
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
                weekChart(),
                monthChart(),
                yearChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
