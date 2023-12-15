





import 'package:flutter/material.dart';






class UserBioScreen extends StatefulWidget {
  @override
  _UserBioScreenState createState() => _UserBioScreenState();
}

class _UserBioScreenState extends State<UserBioScreen> {
  List<Map<String, dynamic>> userBioList = [
    {'name': 'John Doe', 'age': 25},
    {'name': 'Jane Smith', 'age': 30},
    // Add more user bio entries as needed
  ];

  List<Map<String, dynamic>> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Bio List'),
      ),
      body: ListView.builder(
        itemCount: userBioList.length,
        itemBuilder: (context, index) {
          final user = userBioList[index];  //snapshot.data[index]

          return ListTile(
            leading: Checkbox(
              value: selectedUsers.contains(user),
              onChanged: (bool? value) {
                setState(() {
                  if (value != null && value) {
                    // Checkbox is checked, add user to the selected list
                    selectedUsers.add(user);
                  } else {
                    // Checkbox is unchecked, remove user from the selected list
                    selectedUsers.remove(user);
                  }
                });
              },
            ),
            title: Text(user['name']),
            subtitle: Text('Age: ${user['age']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Display the selected users in the console
          print("Selected Users: $selectedUsers");
        },
        child: Icon(Icons.check),
      ),
    );
  }
}