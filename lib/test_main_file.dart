import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DynamicTabBar(),
    );
  }
}

class DynamicTabBar extends StatefulWidget {
  @override
  _DynamicTabBarState createState() => _DynamicTabBarState();
}

class _DynamicTabBarState extends State<DynamicTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabNames = ["New", "Rejected", "Dynamic","Dynamic","New", "Rejected", "Dynamic","Dynamic",];


  List<List<String>> tabContents = [
    ["Agens Neilson", "Peter Doppler", "Urichc Neilson"],
    ["John Doe", "Jane Smith", "Alice Johnson"],
    ["Tom Hanks", "Emma Watson", "Robert Downey Jr."]
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic TabBar Example"),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabNames
              .map((name) => Tab(text: name))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabContents
            .map((content) => ListView.builder(
          itemCount: content.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(content[index]),
              subtitle: Text('email@demo.com'),
            );
          },
        ))
            .toList(),
      ),
    );
  }
}
