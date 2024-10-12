import 'package:flutter/material.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Drawer Example'),
        ),
        drawer: Drawer(
          child: ListView(
            // padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context); 
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context); 
                },
              ),
            ],
          ),
        ),
    );
  }
}

void main() {
  runApp(const DrawerBar());
}