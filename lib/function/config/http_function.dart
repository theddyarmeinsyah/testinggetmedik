// import 'package:medik/model/post_model.dart';
import 'package:medik/model/post_model.dart';
import 'package:medik/services/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid.dart';


// Future<String> insertPost(String apiBaseUrl, String email, String pswd) async {
Future<String> insertPost(String apiBaseUrl, Map<String, dynamic> payload, url) async {
  print(payload);
  String response = await httpPost(
    apiBaseUrl + url,
    payload,
    '',
    10,
  );
  print('cekresponse ' + response);
  return response;
}

Future<String> inputPostSignature(String apiBaseUrl, datax, url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var data = {
    // "data": {
    //   "action": "updateEmail",
    //   "email": email,
    // },
    "data":{
      datax,
    }
  };

  Map<String, dynamic> payload = {
    "payload": {
      "signature": encodeJWT(
        data,
        prefs.getString('x_api_key'),
      ),
      "data": data['data'],
      "requestUuid": Uuid().v4().toString(),
    },
  };

  String response = await httpPost(
    apiBaseUrl + url,
    payload,
    prefs.getString('access_token'),
    30,
  );

  return response;
}

Future<String> inputPostSignatureJWT(String apiBaseUrl, datax, url) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  var data = {
    // "data": {
    //   "action": "updateEmail",
    //   "email": email,
    // },
    "data": datax,
  };

  print(data);

  Map<String, dynamic> payload = {
    "payload": {
      "signature": encodeJWT(
        data,
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwYXlsb2FkIjp7ImRhdGEiOnsiYWN0aW9uIjoidGVzdF91c2VyIiwibmFtZSI6ImtlYW5kcm8iLCJlbWFpbCI6ImtlYW5kcm96YWtraWFAZ21haWwuY29tIiwiZmxhZyI6MH19LCJpYXQiOjE2MTU0NjM2ODYsImV4cCI6MTYxNTQ2MzcxNn0.hN7CkZ6BlGbV2BbHqKoqWx7L_MttBpskDZv9CzZ2w1k',
      ),
      "data": data['data'],
      "requestUuid": 'a36d6207-27c9-4052-89be-be42b7cec34a',
    },
  };

  String response = await httpPostNoToken(
    apiBaseUrl + url,
    payload,
    // 'a36d6207-27c9-4052-89be-be42b7cec34a',
    30,
  );
  print(response);
  return response;
}

Future<String> getPostSignature(String apiBaseUrl, datax, url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var data = {
    "data": datax,
  };
  
  Map<String, dynamic> payload = {
    "payload": {
      "signature": encodeJWT(
        data,
        prefs.getString('x_api_key'),
      ),
      "data": data['data'],
      "requestUuid": Uuid().v4().toString(),
    },
  };

  String response = await httpPost(
    apiBaseUrl + url,
    payload,
    prefs.getString('access_token'),
    90,
  );

  return response;
}

