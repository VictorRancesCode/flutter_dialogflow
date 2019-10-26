import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialogflow/v2/message.dart';

class BasicCardWidget extends StatelessWidget {
  BasicCardWidget({this.card});

  final BasicCardDialogflow card;

  List<Widget> generateButton() {
    List<Widget> buttons = [];

    for (var i = 0; i < this.card.buttons.length; i++) {
      buttons.add(new SizedBox(
          width: double.infinity,
          child: new RaisedButton(
            onPressed: () {},
            color: Colors.green,
            textColor: Colors.white,
            child: Text(this.card.buttons[i]['title']),
          )));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: new Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: Image.network(this.card.image.imageUri),
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    this.card.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    this.card.subtitle,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(this.card.formattedText),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Column(
                children: generateButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
