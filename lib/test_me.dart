import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<TextEditingController>> textControllersList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Icon List with TextFields'),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          // Create text controllers for each icon
          if (textControllersList.length <= index) {
            textControllersList.add(List<TextEditingController>.generate(
              5,
              (i) => TextEditingController(),
            ));
          }

          return ListTile(
            leading: Icon(Icons.star), // You can use different icons here.
            title: Text('Item $index'),
            onTap: () {
              _showTextFields(index);
            },
          );
        },
      ),
    );
  }

  void _showTextFields(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (i) {
              return TextField(
                controller: textControllersList[index][i],
                decoration: InputDecoration(
                  labelText: 'Field $i',
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
