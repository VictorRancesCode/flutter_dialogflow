import 'package:test/test.dart';

import 'package:dialogflow/dialogflow.dart';

void main() {
  test('Test Dialogflow', () async {
    Dialogflow dialogflow =
        Dialogflow(token: "Your Token");
    AIResponse response = await dialogflow.sendQuery("hello world");
    if (response.getStatus.getCode != 200)
      expect(false, throwsNoSuchMethodError);
  });
}
