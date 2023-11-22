import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;











class ControllerSet {
  TextEditingController usernameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController idController = TextEditingController();
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> textFields = [];
  List<ControllerSet> controllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ControllerSet controllerSet = ControllerSet();
                  textFields.add(buildTextField(controllerSet));
                  controllers.add(controllerSet);
                });
              },
              child: Icon(Icons.add),
            ),
            SizedBox(height: 20),
            Column(
              children: textFields,
            ),
            ElevatedButton(
              onPressed: () {
                sendPutRequest();
              },
              child: Text('Send PUT Request'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(ControllerSet controllerSet) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controllerSet.usernameController,
        decoration: InputDecoration(
          hintText: 'Username',
          suffixIcon: GestureDetector(
            onTap: () {
              showAdditionalFields(controllerSet);
            },
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }

  void showAdditionalFields(ControllerSet controllerSet) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAdditionalTextField('Age', controllerSet.ageController),
              buildAdditionalTextField('DOB', controllerSet.dobController),
              buildAdditionalTextField('ID', controllerSet.idController),
            ],
          ),
        );
      },
    );
  }

  Widget buildAdditionalTextField(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }

  void sendPutRequest() async {
    // Assuming a hypothetical endpoint
    String url = 'https://example.com/api/data';

    for (int i = 0; i < controllers.length; i++) {
      ControllerSet controllerSet = controllers[i];

      String username = controllerSet.usernameController.text;
      String age = controllerSet.ageController.text;
      String dob = controllerSet.dobController.text;
      String id = controllerSet.idController.text;

      // Create the PUT request
      http.Response response = await http.put(
        Uri.parse(url),
        body: {
          'username': username,
          'age': age,
          'dob': dob,
          'id': id,
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('PUT request successful!');
      } else {
        print('PUT request failed with status: ${response.statusCode}');
      }
    }
  }
}
