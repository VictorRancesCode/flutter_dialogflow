library flutter_dialogflow;

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Status {
  int _code;
  String _errorType;
  String _errorDetails;

  Status(Map response) {
    this._code = response["code"];
    this._errorType = response["errorType"];
    this._errorDetails = response["errorDetails"];
  }

  int get getCode => _code;

  set code(int value) {
    _code = value;
  }

  String get getErrorType => _errorType;

  set errorType(String value) {
    _errorType = value;
  }

  String get getErrorDetails => _errorDetails;

  set errorDetails(String value) {
    _errorDetails = value;
  }
}

class Fulfillment {
  String _speech;
  dynamic _messages;

  Fulfillment(Map response) {
    this._speech = response["speech"];
    this._messages = response["messages"];
  }

  getMessageResponse() {
    return this._messages[0]["speech"];
  }

  getSpeechResponse() {
    return this._speech;
  }

  String get getSApeech => _speech;

  set speech(String value) {
    _speech = value;
  }

  dynamic get getMessages => _messages;

  set messages(dynamic value) {
    _messages = value;
  }
}

class Metadata {
  String _intentId;
  String _webhookUsed;
  String _webhookForSlotFillingUsed;
  String _intentName;

  Metadata(Map response) {
    this._intentId = response["intentId"];
    this._webhookUsed = response["webhookUsed"];
    this._webhookForSlotFillingUsed = response["webhookForSlotFillingUsed"];
    this._intentName = response["intentName"];
  }

  String get getIntentId => _intentId;

  set intentId(String value) {
    _intentId = value;
  }

  String get getWebhookUsed => _webhookUsed;

  set webhookUsed(String value) {
    _webhookUsed = value;
  }

  String get getWebhookForSlotFillingUsed => _webhookForSlotFillingUsed;

  set webhookForSlotFillingUsed(String value) {
    _webhookForSlotFillingUsed = value;
  }

  String get getIntentName => _intentName;

  set intentName(String value) {
    _intentName = value;
  }
}

class Result {
  String _source;
  String _action;
  String _resolvedQuery;
  bool _actionIncomplete;
  Map _parameters;
  dynamic _contexts;
  Metadata _metadata;
  Fulfillment _fulfillment;
  double _score;

  Result(Map response) {
    this._source = response["source"];
    this._action = response["action"];
    this._resolvedQuery = response["resolvedQuery"];
    this._actionIncomplete = response["actionIncomplete"];
    this._parameters = response["parameters"];
    this._contexts = response["contexts"];
    this._metadata = new Metadata(response["metadata"]);
    this._fulfillment = new Fulfillment(response["fulfillment"]);
    this._score = response["score"];
  }

  String get getSource => _source;

  set source(String value) {
    _source = value;
  }

  String get getAction => _action;

  set action(String value) {
    _action = value;
  }

  String get getResolvedQuery => _resolvedQuery;

  set resolvedQuery(String value) {
    _resolvedQuery = value;
  }

  bool get getActionIncomplete => _actionIncomplete;

  set actionIncomplete(bool value) {
    _actionIncomplete = value;
  }

  Map get getParameters => _parameters;

  set parameters(Map value) {
    _parameters = value;
  }

  dynamic get getContexts => _contexts;

  set contexts(dynamic value) {
    _contexts = value;
  }

  Metadata get getMetadata => _metadata;

  set metadata(Metadata value) {
    _metadata = value;
  }

  Fulfillment get getFulfillment => _fulfillment;

  set fulfillment(Fulfillment value) {
    _fulfillment = value;
  }

  double get getScore => _score;

  set score(double value) {
    _score = value;
  }
}

class AIResponse {
  String _id;
  String _timestamp;
  String _lang;
  Result _result;
  Status _status;
  String _sessionId;

  AIResponse(Map response) {
    this._status = new Status(response["status"]);
    if (this._status.getCode != 200) {
      print(this._status.getErrorType);
      print(this._status.getErrorDetails);
      throw new FormatException(this._status.getErrorDetails);
    } else {
      this._id = response["id"];
      this._timestamp = response["timestamp"];
      this._lang = response["lang"];
      this._result = new Result(response["result"]);
    }
  }

  getMessageResponse() {
    return this._result.getFulfillment.getMessageResponse();
  }

  getSpeechResponse() {
    return this._result.getFulfillment.getSpeechResponse();
  }

  String get getId => _id;

  set id(String value) {
    _id = value;
  }

  String get getTimestamp => _timestamp;

  set timestamp(String value) {
    _timestamp = value;
  }

  String get getLang => _lang;

  set lang(String value) {
    _lang = value;
  }

  Result get getResult => _result;

  set result(Result value) {
    _result = value;
  }

  Status get getStatus => _status;

  set status(Status value) {
    _status = value;
  }

  String get getsessionId => _sessionId;

  set sessionId(String value) {
    _sessionId = value;
  }
}

class Dialogflow {
  final String token;
  final String version;
  final String timezone;
  final String sessionId;
  final String language;

  const Dialogflow(
      {@required this.token,
      this.version = "20170712",
      this.timezone = "America/New_York",
      this.sessionId = "12345",
      this.language = "en"});

  String _getUrl(query) {
    return "https://api.dialogflow.com/v1/query?v=$version&contexts=$query"
        "&lang=es&query=$query&lang=$language&sessionId=$sessionId&timezone=$timezone";
  }

  Future<AIResponse> sendQuery(query) async {
    var response = await http.get(
      _getUrl(query),
      headers: {HttpHeaders.AUTHORIZATION: "Bearer " + token},
    );
    Map data = json.decode(response.body);
    AIResponse aiResponse = new AIResponse(data);
    return aiResponse;
  }
}