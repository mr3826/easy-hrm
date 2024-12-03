import 'package:flutter/material.dart';

void main() {
  Car car = Car.namedConstructor("ferrari");

  print(car);
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestTabBarExample(),
    );
  }
}

class TestTabBarExample extends StatefulWidget {
  const TestTabBarExample({super.key});

  @override
  _TestTabBarExampleState createState() => _TestTabBarExampleState();
}

class _TestTabBarExampleState extends State<TestTabBarExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar with Custom Controller'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'This is a test widget that appears above the TabBar.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Content for Tab 1')),
                Center(child: Text('Content for Tab 2')),
                Center(child: Text('Content for Tab 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Car {
  String? brand;

  Car.namedConstructor(this.brand);
}
