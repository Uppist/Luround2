import 'package:flutter/material.dart';





class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> itemList = [];  //ViewModel

  void reorderList(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1; 
      }
      final item = itemList.removeAt(oldIndex);
      itemList.insert(newIndex, item);
    });
  }

  void addItem(String item) {
    if (!itemList.contains(item)) {
      setState(() {
        itemList.add(item);
      });
    }
  }

  void deleteItem(String item) {
    setState(() {
      itemList.remove(item);
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
              onReorder: (oldIndex, newIndex) => reorderList(oldIndex, newIndex) ,
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: ValueKey(index),  //index
                  title: Text(itemList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteItem(itemList[index]),
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