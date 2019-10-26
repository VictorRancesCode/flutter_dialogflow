import 'package:example/widgets/basicCard.dart';
import 'package:example/widgets/carouselSelect.dart';
import 'package:example/widgets/simple_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class GoogleAssistant extends StatefulWidget {
  GoogleAssistant({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GoogleAssistant createState() => new _GoogleAssistant();
}

class _GoogleAssistant extends State<GoogleAssistant> {
  final List<dynamic> _messages = <dynamic>[];
  final TextEditingController _textController = new TextEditingController();
  BuildContext buildContext;
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send,color: Colors.blue,),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  dynamic getWidgetMessage(message) {
    TypeMessage ms = TypeMessage(message);
    if (ms.platform == "ACTIONS_ON_GOOGLE") {
      if (ms.type == "simpleResponses") {
        return SimpleMessage(
          text: message['simpleResponses']['simpleResponses'][0]
              ['textToSpeech'],
          name: "Bot",
          type: false,
        );
      }
      if (ms.type == "basicCard") {
        return BasicCardWidget(card: BasicCardDialogflow(message));
      }
      if (ms.type == "carouselSelect") {
        return CarouselSelectWidget(
            carouselSelect: CarouselSelect(message),
            clickItem: (info) {
              print(info); // Item Click print List Keys
            });
      }
    }
    return null;
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "Asset Your File Json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    if (response.getMessage() != null && response.getMessage() != "") {
      SimpleMessage message = new SimpleMessage(
        text: response.getMessage(),
        name: "Bot",
        type: false,
      );
      setState(() {
        _messages.insert(0, message);
      });
    } else {
      List<dynamic> messages = response.getListMessage();
      for (var i = 0; i < messages.length; i++) {
        dynamic message = getWidgetMessage(messages[i]);
        if (message != null) {
          setState(() {
            _messages.insert(0, message);
          });
        }
      }
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    SimpleMessage message = new SimpleMessage(
      text: text,
      name: "Rances",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    this.buildContext=context;
    return new Scaffold(
      backgroundColor: Color(0xf4f4f4f4f4),
      appBar: new AppBar(
        title: new Text("Google Assistant"),
        backgroundColor: Colors.blue,
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}
