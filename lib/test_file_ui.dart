import 'dart:ffi';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add intl package to your pubspec.yaml

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        home: EventCalendarDemo(),
      ),
    );
  }
}

class SliverAppBarDemo extends StatefulWidget {
  const SliverAppBarDemo({super.key});

  @override
  State<SliverAppBarDemo> createState() => _SliverAppBarDemoState();
}

class _SliverAppBarDemoState extends State<SliverAppBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            backgroundColor: Colors.red,
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 400,
              color: Colors.green,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 400,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class EventCalendarDemo extends StatefulWidget {
  const EventCalendarDemo({super.key});

  @override
  State<EventCalendarDemo> createState() => _EventCalendarDemoState();
}

class _EventCalendarDemoState extends State<EventCalendarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 1400,
              child: DayView(),
            ),
          ],
        ),
      )),
    );
  }
}

class DateListView extends StatefulWidget {
  @override
  _DateListViewState createState() => _DateListViewState();
}

class _DateListViewState extends State<DateListView> {
  final Map<int, List<String>> dateMap = generateDateMap(2023, 2025);
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _keys = {};
  String currentMonthKey = '';
  String selectedMonthKey = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentMonth();
    });
  }

  void _scrollToCurrentMonth() {
    DateTime now = DateTime.now();
    String currentMonth =
        DateFormat('MMMM').format(now); // e.g., Jan, Feb, etc.
    currentMonthKey = '${now.year}-$currentMonth';
    selectedMonthKey = currentMonthKey;
    _scrollToKey(currentMonthKey);
  }

  void _scrollToKey(String key) {
    final context = _keys[key]?.currentContext;
    if (context != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(seconds: 1),
          alignment: 0.5,
        );
      });
    }
  }

  void _onMonthTap(int year, String month) {
    setState(() {
      selectedMonthKey = '$year-$month';
    });
    print('Clicked: $year $month');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date ListView'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dateMap.entries.expand((entry) {
              List<Widget> widgets = [];
              widgets.add(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    entry.key.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              );
              widgets.addAll(
                entry.value.map((month) {
                  String key = '${entry.key}-$month';
                  GlobalKey monthKey = GlobalKey();
                  _keys[key] = monthKey;
                  return Padding(
                    key: monthKey,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: InkWell(
                      onTap: () => _onMonthTap(entry.key, month),
                      child: Column(
                        children: [
                          Text(
                            month,
                            style: TextStyle(
                              fontSize: 16,
                              color: key == selectedMonthKey
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                          key == selectedMonthKey
                              ? Text(
                                  entry.key.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: key == selectedMonthKey
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
              return widgets;
            }).toList(),
          ),
        ),
      ),
    );
  }
}

Map<int, List<String>> generateDateMap(int startYear, int endYear) {
  Map<int, List<String>> dateMap = {};
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  for (int year = startYear; year <= endYear; year++) {
    dateMap[year] = months;
  }

  return dateMap;
}
