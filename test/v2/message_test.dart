import 'package:flutter_dialogflow/v2/message.dart';
import 'package:flutter_test/flutter_test.dart';

import 'message_test_util.dart';

main() {
  test("Card", () {
    final message = TypeMessage.fromJson(MessageTestUtil.cardMessageJson);

    expect(message.type, MessageType.card);
    expect(message.value, isA<CardDialogflow>());
  });

  test("BasicCard", () {
    final message = TypeMessage.fromJson(MessageTestUtil.basicCardMessageJson);

    expect(message.type, MessageType.basicCard);
    expect(message.value, isA<BasicCardDialogflow>());
  });

  test("SimpleResponses", () {
    final message =
        TypeMessage.fromJson(MessageTestUtil.simpleResponsesMessageJson);

    expect(message.type, MessageType.simpleResponses);
    expect(message.value, isA<SimpleResponses>());
  });

  test("CarouselSelect", () {
    final message = TypeMessage.fromJson(MessageTestUtil.carouselSelectMessageJson);

    expect(message.type, MessageType.carouselSelect);
    expect(message.value, isA<CarouselSelect>());
  });

  test("Text", () {
    final message = TypeMessage.fromJson(MessageTestUtil.textMessageJson);

    expect(message.type, MessageType.text);
    expect(message.value, isA<ListTextDialogflow>());
  });

  test("Map", () {
    final message = TypeMessage.fromJson({
      "platform": "google",
      "xyz": {},
    });

    expect(message.type, MessageType.map);
    expect(message.value, isA<Map>());
  });
}
