class MessageTestUtil {
  static const cardMessageJson =         {
    "platform": "google",
    "card": {
      "title": "title",
      "subtitle": "subtitle",
      "imageUri": "imageUri",
      "buttons": [
        {
          "text": "text",
          "postback": "postback"
        }
      ]
    }
  };

  static const basicCardMessageJson = {
    "platform": "google",
    "basicCard" : {
      "title": "title",
      "subtitle": "subtitle",
      "formattedText": "formattedText",
      "image": {
        "imageUri": "imageUri",
        "accessibilityText": "accessibilityText"
      },
      "buttons": [
        {
          "title": "title",
          "openUriAction": {
            "uri": "uri"
          }
        }
      ]
    }
  };

  static const simpleResponsesMessageJson = {
    "platform": "google",
    "simpleResponses" :   {
      "simpleResponses": [
        {
          "textToSpeech": "textToSpeech",
          "ssml": "ssml",
          "displayText": "displayText"
        }
      ]
    }
  };

  static const carouselSelectMessageJson = {
    "platform": "google",
    "carouselSelect" : {
      "items": [
        {
          "info": {
            "key": "key",
            "synonyms": [
              "keySynonyms"
            ]
          },
          "title": "title",
          "description": "description",
          "image": {
            "imageUri": "imageUri",
            "accessibilityText": "accessibilityText"
          }
        }
      ],
    },
  };

  static const textMessageJson = {
    "platform": "google",
    "text": {
      "text": [
        "Simple text message"
      ]
    }
  };
}