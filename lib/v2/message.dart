class ListTextDialogflow {
  List<String> listText = [];

  ListTextDialogflow(Map response) {
    List<dynamic> list_text = response['text']['text'];
    list_text.forEach((element)=> this.listText.add(element));
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
  List<String> quickReplies=[];

  QuickReplies(Map response) {
    this.title = response['quickReplies']['title'];
    List<dynamic> list_quickReplies = response['quickReplies']['quickReplies'];
    list_quickReplies.forEach((element)=> this.quickReplies.add(element));
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
  List<ButtonDialogflow> buttons=[];

  CardDialogflow(Map response) {
    this.title = response['card']['title'];
    this.subtitle = response['card']['subtitle'];
    this.imageUri = response['card']['imageUri'];
    List<dynamic> list_buttons = response['card']['buttons'];
    for (int i = 0; i < list_buttons.length; i++) {
      ButtonDialogflow b =new ButtonDialogflow(list_buttons[i]);
      buttons.add(b);
    }
  }
}

class SimpleResponse {
  String textToSpeech;
  String ssml;
  String displayText;

  SimpleResponse(Map response){
    this.textToSpeech = response['textToSpeech'];
    this.ssml = response['ssml'];
    this.displayText = response['displayText'];
  }
}

class SimpleResponses {
  List<SimpleResponse> simpleResponses =[];

  SimpleResponses(Map response){
    List<dynamic> listSimpleResponse = response['simpleResponses']['simpleResponses'];
    for (int i = 0; i < listSimpleResponse.length; i++) {
      SimpleResponse b =new SimpleResponse(listSimpleResponse[i]);
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
    this.image = new ImageDialogflow(response['basicCard']['image']) ;
    this.buttons = response['basicCard']['buttons'];
  }
}
