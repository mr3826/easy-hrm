import 'package:flutter/material.dart';

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PageView Example')),
      body: PageView.builder(
        itemCount: 5, // Number of pages
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: EdgeInsets.zero, // Remove any padding here
              child: Text(
                'Page $index',
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyPageView(),
  ));
}
