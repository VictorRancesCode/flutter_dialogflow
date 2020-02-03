import 'dart:convert';
import 'dart:io';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:meta/meta.dart';

class Intent {
  String name;
  String displayName;

  Intent(Map data) {
    name = data["name"];
    displayName = data["displayName"];
  }
}

class QueryResult {
  String queryText;
  String action;
  Map parameters;
  bool allRequiredParamsPresent;
  String fulfillmentText;
  List<dynamic> fulfillmentMessages;
  Intent intent;

  QueryResult(Map data) {
    queryText = data["queryText"];
    action = data["action"];
    parameters = data["parameters"] ?? null;
    allRequiredParamsPresent = data["allRequiredParamsPresent"];
    fulfillmentText = data["fulfillmentText"];
    intent = data['intent'] != null ? new Intent(data['intent']) : null;

    fulfillmentMessages = data['fulfillmentMessages'];
  }
}

class DiagnosticInfo {
  String webhookLatencyMs;

  DiagnosticInfo(Map response) {
    webhookLatencyMs = response["webhook_latency_ms"];
  }
}

class WebhookStatus {
  String message;

  WebhookStatus(Map response) {
    message = response['message'];
  }
}

class AIResponse {
  String _responseId;
  QueryResult _queryResult;
  num _intentDetectionConfidence;
  String _languageCode;
  DiagnosticInfo _diagnosticInfo;
  WebhookStatus _webhookStatus;

  AIResponse({Map body}) {
    _responseId = body['responseId'];
    _intentDetectionConfidence = body['intentDetectionConfidence'];
    _queryResult = new QueryResult(body['queryResult']);
    _languageCode = body['languageCode'];
    _diagnosticInfo = (body['diagnosticInfo'] != null
        ? new DiagnosticInfo(body['diagnosticInfo'])
        : null);
    _webhookStatus = body['webhookStatus'] != null
        ? new WebhookStatus(body['webhookStatus'])
        : null;
  }

  String get responseId {
    return _responseId;
  }

  String getMessage() {
    return _queryResult.fulfillmentText;
  }

  String getWebhookStatusMessage() {
    return _webhookStatus.message;
  }

  List<dynamic> getListMessage() {
    return _queryResult.fulfillmentMessages;
  }

  num get intentDetectionConfidence {
    return _intentDetectionConfidence;
  }

  String get languageCode {
    return _languageCode;
  }

  DiagnosticInfo get diagnosticInfo {
    return _diagnosticInfo;
  }

  WebhookStatus get webhookStatus {
    return _webhookStatus;
  }

  QueryResult get queryResult {
    return _queryResult;
  }
}

class Dialogflow {
  final AuthGoogle authGoogle;
  final String language;
  final String payload;
  final bool resetContexts;

  const Dialogflow({@required this.authGoogle, this.language="en", this.payload="", this.resetContexts=false});

  String _getUrl() {
    return "https://dialogflow.googleapis.com/v2/projects/${authGoogle.getProjectId}/agent/sessions/${authGoogle.getSessionId}:detectIntent";
  }


  Future<AIResponse> detectIntent(String query) async {

    String queryParams = '{"resetContexts": ${this.resetContexts} }';

    if (payload.isNotEmpty) {
      queryParams = '{"resetContexts": ${this.resetContexts}, "payload": $payload}';
    }

    String body = '{"queryInput":{"text":{"text":"$query","language_code":"$language"}}, "queryParams": $queryParams}';

    var response = await authGoogle.post(_getUrl(),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${authGoogle.getToken}"
        },
        body: body);

    return AIResponse(body: json.decode(response.body));
  }
}
