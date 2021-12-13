import 'package:example/basic_example.dart';
import 'package:example/drag_handle_example.dart';
import 'package:example/drag_into_list_example.dart';
import 'package:example/fixed_example.dart';
import 'package:example/list_tile_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guardian Angle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BasicExample(),
        '/list_tile_example': (context) => ListTileExample(),
        '/drag_into_list_example': (context) => DragIntoListExample(),
        '/fixed_example': (context) => FixedExample(),
        '/drag_handle_example': (context) => DragHandleExample(),
      },
    );
  }
}
