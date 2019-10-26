import 'package:example/dialogflow_v1.dart';
import 'package:example/dialogflow_v2.dart';
import 'package:flutter/material.dart';

import 'google_assistant.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Example Dialogflow Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new MyHomePage(title: 'Flutter Demo Dialogflow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(children: <Widget>[
        new Container(
          margin: EdgeInsets.all(10.0),
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageDialogflowV1()),
              );
            },
            child: Text("Dialogflow v1"),
          ),
        ),
        new Container(
          margin: EdgeInsets.all(10.0),
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePageDialogflowV2()),
              );
            },
            child: Text("Dialogflow v2"),
          ),
        ),
        new Container(
          margin: EdgeInsets.all(10.0),
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoogleAssistant()),
              );
            },
            child: Text("GoogleAssistant"),
          ),
        )
      ]),
    );
  }
}
