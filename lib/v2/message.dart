class ListTextDialogflow {
  List<String> listText = [];

  ListTextDialogflow(Map response) {
    List<dynamic> listText = response['text']['text'];
    listText.forEach((element) => this.listText.add(element));
  }
}

class ImageDialogflow {
  String imageUri;
  String accessibilityText;

  ImageDialogflow(Map response) {
    this.imageUri = response['imageUri'];
    this.accessibilityText = response['accessibilityText'];
  }
}

class QuickReplies {
  String title;
  List<String> quickReplies = [];

  QuickReplies(Map response) {
    this.title = response['quickReplies']['title'];
    List<dynamic> listQuickReplies = response['quickReplies']['quickReplies'];
    listQuickReplies.forEach((element) => this.quickReplies.add(element));
  }
}

class ButtonDialogflow {
  String text;
  String postback;

  ButtonDialogflow(Map response) {
    text = response['text'];
    postback = response['postback'];
  }
}

class CardDialogflow {
  String title;
  String subtitle;
  String imageUri;
  List<ButtonDialogflow> buttons = [];

  CardDialogflow(Map response) {
    this.title = response['card']['title'];
    this.subtitle = response['card']['subtitle'];
    this.imageUri = response['card']['imageUri'];
    List<dynamic> listButtons = response['card']['buttons'];
    for (int i = 0; i < listButtons.length; i++) {
      ButtonDialogflow b = new ButtonDialogflow(listButtons[i]);
      buttons.add(b);
    }
  }
}

class SimpleResponse {
  String textToSpeech;
  String ssml;
  String displayText;

  SimpleResponse(Map response) {
    this.textToSpeech = response['textToSpeech'];
    this.ssml = response['ssml'];
    this.displayText = response['displayText'];
  }
}

class SimpleResponses {
  List<SimpleResponse> simpleResponses = [];

  SimpleResponses(Map response) {
    List<dynamic> listSimpleResponse =
        response['simpleResponses']['simpleResponses'];
    for (int i = 0; i < listSimpleResponse.length; i++) {
      SimpleResponse b = new SimpleResponse(listSimpleResponse[i]);
      simpleResponses.add(b);
    }
  }
}

class BasicCardDialogflow {
  String title;
  String subtitle;
  String formattedText;
  ImageDialogflow image;
  List<dynamic> buttons;

  BasicCardDialogflow(Map response) {
    this.title = response['basicCard']['title'];
    this.subtitle = response['basicCard']['subtitle'];
    this.formattedText = response['basicCard']['formattedText'];
    this.image = new ImageDialogflow(response['basicCard']['image']);
    this.buttons = response['basicCard']['buttons'];
  }
}

class ItemCarousel {
  dynamic info;
  String title;
  String description;
  ImageDialogflow image;
  ItemCarousel(Map item) {
    this.info = item['info'];
    this.title = item['title'];
    this.description = item['description'];
    this.image = new ImageDialogflow(item['image']);
  }
}

class CarouselSelect {
  List<ItemCarousel> items = [];
  CarouselSelect(Map response) {
    List<dynamic> list = response['carouselSelect']['items'];
    for (var i = 0; i < list.length; i++) {
      items.add(new ItemCarousel(list[i]));
    }
  }
}

class MessageType {
  final String value;

  const MessageType._(this.value);

  static const card = MessageType._('card');
  static const basicCard = MessageType._('basicCard');
  static const simpleResponses = MessageType._('simpleResponses');
  static const carouselSelect = MessageType._('carouselSelect');
  static const text = MessageType._("text");
  static const map = MessageType._("map");
}

class TypeMessage {
  final String platform;
  final MessageType type;
  final Object value;

  TypeMessage(this.platform, this.type, this.value);

  static TypeMessage fromJson(Map data) {
    final platform = data['platform'] ?? "";
    if (data.containsKey('card')) {
      return TypeMessage(
        platform,
        MessageType.card,
        CardDialogflow(data),
      );
    } else if (data.containsKey('basicCard')) {
      return TypeMessage(
        platform,
        MessageType.basicCard,
        BasicCardDialogflow(data),
      );
    } else if (data.containsKey('simpleResponses')) {
      return TypeMessage(
        platform,
        MessageType.simpleResponses,
        SimpleResponses(data),
      );
    } else if (data.containsKey('carouselSelect')) {
      return TypeMessage(
        platform,
        MessageType.carouselSelect,
        CarouselSelect(data),
      );
    } else if (data.containsKey("text")) {
      return TypeMessage(
        platform,
        MessageType.text,
        ListTextDialogflow(data),
      );
    } else {
      return TypeMessage(
        platform,
        MessageType.map,
        data,
      );
    }
  }
}
