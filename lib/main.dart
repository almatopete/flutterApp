import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Widgets Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text Widget
              Text(
                'Hello, Flutter!',
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),

              SizedBox(height: 20), // Espacio entre widgets

              // Row Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 30),
                  Text(
                    'Row Widget Example',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.star, color: Colors.amber, size: 30),
                ],
              ),

              SizedBox(height: 20), // Espacio entre widgets

              // Stack Widget
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.greenAccent,
                  ),
                  Text(
                    'Stacked Text',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),

              SizedBox(height: 20), // Espacio entre widgets

              // Container Widget
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Container with Padding and BorderRadius',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
