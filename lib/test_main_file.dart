import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs; // Track the selected tab index
  late PageController pageController; // For smooth scrolling

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
        initialPage: selectedIndex.value,
        viewportFraction: 0.9); // Set viewportFraction for smooth swipe
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class TabViewScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  final tabs = [
    {"text": "New", "value": "03", "id": "1"},
    {"text": "Rejected", "value": "04", "id": "2"},
    {"text": "Interview", "value": "07", "id": "3"},
    {"text": "Task assigned", "value": "08", "id": "4"},
    {"text": "Hired", "value": "09", "id": "5"},
    {"text": "Offer", "value": "01", "id": "6"},
    {"text": "Completed", "value": "02", "id": "7"},
    {"text": "Pending", "value": "06", "id": "8"},
    {"text": "On Hold", "value": "05", "id": "9"},
    {"text": "On Hold", "value": "05", "id": "9"},
    {"text": "On Hold", "value": "05", "id": "9"},
  ];

  // Create ScrollController to control tabBar scrolling
  final ScrollController tabsScrollController = ScrollController();

  TabViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Candidates'),
      ),
      body: Column(
        children: [
          Obx(() {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: tabsScrollController, // Attach the controller
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      final isSelected =
                          controller.selectedIndex.value == index;

                      return GestureDetector(
                        onTap: () {
                          controller.selectedIndex.value = index;
                          controller.pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    tabs[index]["text"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.blue.withOpacity(0.1)
                                          : Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tabs[index]["value"]!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 50),
                                height: 2,
                                width: isSelected
                                    ? _getTextWidth(
                                    "${tabs[index]["text"] ?? ""} ${tabs[index]["value"] ?? ""}")
                                    : 0, // Smooth width transition
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          }),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: tabs.length,
              onPageChanged: (index) {
                controller.selectedIndex.value = index; // Update selected tab

                // Check if we need to auto-scroll based on index
                _autoScrollTabs(index, context);
              },
              itemBuilder: (context, index) {
                return CandidateListView(tabId: tabs[index]["id"] ?? "");
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle the auto-scroll logic
  void _autoScrollTabs(int index, context) {
    double tabWidth = 150; // Adjust this according to your tab width
    double position;

    // Auto-scroll when index crosses a multiple of 4 (either direction)
    if (index >= 2) {
      position = (index - 2) * tabWidth; // Scroll to the next set of 4 items
    } else {
      position = 0.0; // If index is below 4, scroll back to the start
    }

    // Animate the scroll
    tabsScrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  double _getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: "   $text    "),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}

class CandidateListView extends StatelessWidget {
  final String tabId;

  const CandidateListView({super.key, required this.tabId});

  @override
  Widget build(BuildContext context) {
    // Example data for the list
    final RxList<Map<String, String>> tabBarUserList = [
      {"text": "Agnes Neilson", "value": "03", "id": "1", "status": "New"},
      {"text": "John Doe", "value": "04", "id": "2", "status": "Rejected"},
      {"text": "Sara Smith", "value": "07", "id": "3", "status": "Interview"},
    ].obs;

    return Obx(() {
      // Filter the list based on the tabId
      final filteredList =
      tabBarUserList.where((user) => user["id"] == tabId).toList();

      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final user = filteredList[index];

          return ListTile(
            title: Text(user["text"] ?? ""),
            subtitle: Text(user["status"] ?? ""),
            onTap: () =>
                Get.snackbar("Candidate", "Details for ${user['text']}"),
          );
        },
      );
    });
  }
}

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabViewScreen(),
    ),
  );
}

