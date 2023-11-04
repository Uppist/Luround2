import 'package:flutter/material.dart';





class ToggleContainerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5, // Number of containers
        itemBuilder: (context, index) {
          return ToggleContainer(index: index);
        },
      ),
    );
  }
}

class ToggleContainer extends StatefulWidget {
  final int index;

  ToggleContainer({required this.index});

  @override
  _ToggleContainerState createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainer> {
  bool isDogSelected = true;

  void togglePet() {
    setState(() {
      isDogSelected = !isDogSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Container ${widget.index + 1}'),
          CustomToggleButton(
            isDogSelected: isDogSelected,
            onToggle: togglePet,
          ),
        ],
      ),
    );
  }
}

class CustomToggleButton extends StatelessWidget {
  final bool isDogSelected;
  final VoidCallback onToggle;

  CustomToggleButton({required this.isDogSelected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onToggle();
          },
          child: Container(
            decoration: BoxDecoration(
              color: isDogSelected ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Dog',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onToggle();
          },
          child: Container(
            decoration: BoxDecoration(
              color: isDogSelected ? Colors.grey : Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Cat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}