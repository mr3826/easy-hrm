import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KanbanBoardPageView(),
    );
  }
}

class KanbanBoardPageView extends StatefulWidget {
  @override
  _KanbanBoardPageViewState createState() => _KanbanBoardPageViewState();
}

class _KanbanBoardPageViewState extends State<KanbanBoardPageView> {
  final List<String> columns = ["To Do", "In Progress", "Done"];
  final Map<String, List<String>> tasks = {
    "To Do": ["Task 1", "Task 2", "Task 3"],
    "In Progress": ["Task 4"],
    "Done": ["Task 5", "Task 6"],
  };

  String? draggedItem; // Currently dragged task
  String? sourceColumn; // The column from which the item is dragged
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kanban Board")),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: columns.length,
            itemBuilder: (context, index) {
              return buildColumn(columns[index]);
            },
          ),
          if (draggedItem != null) buildDraggedItemFeedback(),
        ],
      ),
    );
  }

  Widget buildColumn(String column) {
    return DragTarget<String>(
      onAccept: (task) {
        setState(() {
          tasks[column]!.add(task);
          if (sourceColumn != null) {
            tasks[sourceColumn]!.remove(task);
          }
          draggedItem = null;
          sourceColumn = null;
        });
      },
      onWillAccept: (data) => true, // Always accept drops
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column Title
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Center(
                  child: Text(
                    column,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Task List
              Expanded(
                child: ListView.builder(
                  itemCount: tasks[column]!.length,
                  itemBuilder: (context, index) {
                    return buildTask(tasks[column]![index], column);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTask(String task, String column) {
    return GestureDetector(
      onPanStart: (_) {
        setState(() {
          draggedItem = task;
          sourceColumn = column;
        });
      },
      onPanUpdate: (details) {
        // Handle drag movement
        setState(() {
          // Keep the dragged item following the pointer
        });
      },
      onPanEnd: (_) {
        // Reset drag state if not dropped on a valid target
        if (draggedItem != null) {
          setState(() {
            draggedItem = null;
            sourceColumn = null;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          task,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildDraggedItemFeedback() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                draggedItem ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
