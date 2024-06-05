import 'package:flutter/material.dart';
import 'package:coockie_clicker/widget/levelbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _progress = 0.0;
  int _level = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _progress += 0.1;
      if (_progress >= 1.0) {
        _progress = 0.0;
        _level++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: CustomProgressBar(progress: _progress, level: _level),
        actions: [
          Image.asset('images/dollar.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

