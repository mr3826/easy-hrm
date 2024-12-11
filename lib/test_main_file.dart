import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: YearList(),
  ));
}

class YearList extends StatefulWidget {
  @override
  _YearListState createState() => _YearListState();
}

class _YearListState extends State<YearList> {
  List<int> years = [];
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _generateInitialYears(); // Load the initial years
  }

  /// Generate the initial list of years
  void _generateInitialYears() {
    years = [
      for (int i = 0; i < 25; i++) currentYear - i, // Current and last 24 years
      for (int i = 1; i <= 2; i++) currentYear + i, // Next 2 years
    ];
    setState(() {});
  }

  /// Load more future years when scrolling upwards
  void _loadMoreYears() {
    final lastYear = years.first; // Get the earliest year in the list
    final newYears = [for (int i = 1; i <= 2; i++) lastYear + i]; // Next 2 years
    years.insertAll(0, newYears); // Add at the start of the list
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Year List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        reverse: true, // Display years in descending order (most recent at bottom)
        itemCount: years.length + 1, // Add extra space for the loading indicator
        itemBuilder: (context, index) {
          if (index == 0) {
            // Show loading indicator when at the top of the list
            _loadMoreYears();
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListTile(
            title: Text(
              years[index - 1].toString(), // Adjust index for the loader
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
