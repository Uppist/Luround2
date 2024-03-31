import 'package:flutter/material.dart';

class TabbedSearchScreen extends StatefulWidget {
  @override
  _TabbedSearchScreenState createState() => _TabbedSearchScreenState();
}

class _TabbedSearchScreenState extends State<TabbedSearchScreen> {
  final List<String> books = ['Book 1', 'Book 2', 'Book 3'];
  final List<String> cars = ['Car 1', 'Car 2', 'Car 3'];
  final List<String> pets = ['Pet 1', 'Pet 2', 'Pet 3'];

  List<String> currentItems = []; // Items to display based on active tab
  int activeTabIndex = 0; // Index of the active tab
  String searchText = ''; // Text entered in the search field

  @override
  void initState() {
    super.initState();
    // Initially, set the items to display based on the active tab
    currentItems = books; // Default to books tab
  }

  // Method to filter items based on search text
  List<String> filterItems(List<String> items) {
    return items
        .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Books'),
            Tab(text: 'Cars'),
            Tab(text: 'Pets'),
          ],
          onTap: (index) {
            setState(() {
              // Update active tab index and current items
              activeTabIndex = index;
              if (index == 0) {
                currentItems = books;
              } else if (index == 1) {
                currentItems = cars;
              } else if (index == 2) {
                currentItems = pets;
              }
              // Apply search filter
              currentItems = filterItems(currentItems);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: currentItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currentItems[index]),
          );
        },
      ),
    );
  }
}

