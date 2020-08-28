import 'package:flutter/material.dart';
import 'package:my_lib_example/add_widget.dart';
import 'package:my_lib_example/json_widget.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('FFI example app'),
        ),
        body: Center(
          child: JsonTest(),
        ),
      ),
    );
  }

}
