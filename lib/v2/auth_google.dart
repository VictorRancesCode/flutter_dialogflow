import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AuthGoogle {
  final String fileJson;
  final List<String> scope;
  final String sessionId;
  AuthGoogle({@required this.fileJson,this.scope=const ["https://www.googleapis.com/auth/cloud-platform"],this.sessionId="123"});


  String _projectId;
  AccessCredentials _credentials;


  Future<String> getReadJson() async {
    String data = await rootBundle.loadString(this.fileJson);
    return data;
  }

  Future<AuthGoogle> build() async {
    String readJson = await getReadJson();
    Map jsonData = json.decode(readJson);
    var _credentialsResponse = new ServiceAccountCredentials.fromJson(readJson);
    var data = await clientViaServiceAccount(_credentialsResponse, this.scope);
    _projectId = jsonData['project_id'];
    _credentials = data.credentials;
    return this;
  }

  bool get hasExpired{
    return _credentials.accessToken.hasExpired;
  }

  String get getSessionId{
    return sessionId;
  }
  String get getProjectId{
    return _projectId;
  }

  String get getToken{
    return _credentials.accessToken.data;
  }

  Future<Response> post(url, {Map<String, String> headers, body,
    Encoding encoding}) async{
    if (!hasExpired) {
      return await http.post(url, headers: headers, body:body);
    } else {
      await build();
      return await http.post(url, headers: headers, body:body);
    }
  }
}
