import 'package:flutter/material.dart';





class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> itemList = [];  // Now of type Widget

  void reorderList(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1; 
      }
      final item = itemList.removeAt(oldIndex);
      itemList.insert(newIndex, item);
    });
  }

  void addItem(String itemName) {
    setState(() {
      // Create a Container with the value and add it to the list
      itemList.add(Container(
        key: ValueKey(itemList.length),
        padding: EdgeInsets.all(8.0),
        color: Colors.blue,
        child: Text(itemName, style: TextStyle(color: Colors.white)),
      ));
    });
  }

  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.car_repair),
                onPressed: () => addItem('Carrot'),
              ),
              IconButton(
                icon: Icon(Icons.local_florist),
                onPressed: () => addItem('Onion'),
              ),
              IconButton(
                icon: Icon(Icons.local_grocery_store),
                onPressed: () => addItem('Spinach'),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => addItem('Apple'),
              ),
            ],
          ),
          Expanded(
            child: ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) => reorderList(oldIndex, newIndex),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: ValueKey(index),
                  title: itemList[index],  // Now displaying a Widget directly
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
