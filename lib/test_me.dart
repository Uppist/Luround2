





import 'package:flutter/material.dart';






class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> userList = [
    {'name': 'Jon Doe', 'age': '23', 'date_created': '12-03-2023'},
    {'name': 'Jon hhh', 'age': '236', 'date_created': '12-03-2023'},
    {'name': 'Daniel Tom', 'age': '13', 'date_created': '16-04-2023'},
    // Add more user data as needed
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(userList);
    print(filteredList);
  }

  void filterList(String selectedDate) {
    setState(() {
      if (selectedDate == 'All') {
        filteredList = List.from(userList);
      } else {
        filteredList = userList
            .where((user) => user['date_created'] == selectedDate)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Show a date picker or use any method to select a date
                // For simplicity, I'm using a hardcoded date here
                String selectedDate = '12-03-2023';
                filterList(selectedDate);
              },
              child: Text('Filter by Date'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Name: ${filteredList[index]['name']}'),
                  subtitle: Text('Age: ${filteredList[index]['age']}'),
                  trailing: Text('Date Created: ${filteredList[index]['date_created']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}