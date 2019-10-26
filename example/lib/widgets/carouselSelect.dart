import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialogflow/v2/message.dart';


class ItemCarouselWidget extends StatefulWidget {
  final ItemCarousel item;
  final Function clickItem;
  ItemCarouselWidget({Key key,this.item, this.clickItem}) : super(key: key);

  @override
  _ItemCarouselWidget createState() => _ItemCarouselWidget();
}
class _ItemCarouselWidget extends State<ItemCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
          widget.clickItem(widget.item.info);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: new Container(
            margin: EdgeInsets.all(10.0),
            width: 300.0,
            height: 350.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new NetworkImage(widget.item.image.imageUri),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: null,
                  height: 200.0,
                ),
                new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.item.title,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(widget.item.description),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CarouselSelectWidget extends StatefulWidget {
  CarouselSelectWidget({this.carouselSelect, this.clickItem});

  final Function clickItem;
  final CarouselSelect carouselSelect;

  @override
  _CarouselSelectWidget createState() => _CarouselSelectWidget();
}


class _CarouselSelectWidget extends State<CarouselSelectWidget> {
  List<Widget> listItems() {
    List<Widget> items = [];

    for (var i = 0; i < widget.carouselSelect.items.length; i++) {
      items.add(new ItemCarouselWidget(
          item: widget.carouselSelect.items[i], clickItem: widget.clickItem));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: listItems()),
      ),
    );
  }
}
