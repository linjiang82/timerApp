import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyTimer(title: 'My Timer'),
    );
  }
}

class MyTimer extends StatefulWidget {
  MyTimer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  int _h = 0;
  int _m = 0;
  int _s = 0;
  DateTime timeNow;
  DateTime timeFuture;
  final hourList = <Widget>[];
  final minList = <Widget>[];
  final secList = <Widget>[];

  @override
  void initState() {
    for (var i = 0; i < 24; i++) {
      hourList.add(Text(i.toString()));
    }
    for (var i = 0; i < 60; i++) {
      minList.add(Text(i.toString()));
      secList.add(Text(i.toString()));
    }
    timeNow = new DateTime.now();
    timeFuture = timeNow;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer t = Timer(Duration(seconds: 1), () {
      if (timeFuture.difference(timeNow).inSeconds > 0)
        setState(() {
          timeNow = timeNow.add(Duration(seconds: 1));
        });
    });
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              timeFuture.difference(timeNow).toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (h) {
                    _h = h;
                  },
                  children: hourList,
                  looping: false,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (m) {
                    _m = m;
                  },
                  children: minList,
                  looping: false,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (s) {
                    _s = s;
                  },
                  children: secList,
                  looping: false,
                ),
              ),
            ]),
            RaisedButton(
              onPressed: () {
                t.cancel();
                setState(() {
                  timeNow = new DateTime.now();
                  timeFuture = timeNow
                      .add(Duration(hours: _h, minutes: _m, seconds: _s));
                });
              },
              child: Text('Start'),
            )
          ],
        ),
      ),
    );
  }
}
