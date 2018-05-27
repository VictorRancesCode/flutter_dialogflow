# flutter_dialogflow

A new Flutter package.
* [Example](https://github.com/VictorRancesCode/flutter_dialogflow/tree/master/example)


<p align="center">
  <img src="image1.png" width="350"/>
</p>

## Installation

* Add this to your package's pubspec.yaml file:
```
dependencies:
  flutter_dialogflow: "^0.0.1"
```
* You can install packages from the command line:
  with Flutter:
```
$ flutter packages get
```

* Import it Now in your Dart code, you can use:
```
 import 'package:flutter_dialogflow/flutter_dialogflow.dart';
```


## Usage
* [Dialogflow](https://dialogflow.com/) register and create new Agent
* Copy Api key (Token)
* Code
```
  Dialogflow dialogflow = Dialogflow(token: "Your Token");
  AIResponse response = await dialogflow.sendQuery("Your Query");
```
* Example
```
  void Response(query) async {
    Dialogflow dialogflow = Dialogflow(token: "10178f9cb6cf12321asdf4aae75c87cd");
    AIResponse response = await dialogflow.sendQuery(query);
    print(response.getMessageResponse());
  }
```


## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).