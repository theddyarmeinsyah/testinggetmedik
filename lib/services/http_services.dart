import 'dart:convert';

import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> httpGet(String url, String token, int timeout) async {
  var response;
  try {
    response = await http.get(
      Uri.parse('$url'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptHeader: 'application/json',
      },
    ).timeout(
      Duration(seconds: timeout),
    );
  } on TimeoutException catch (_) {
    return StaticParameter.timeout;
  } on SocketException catch (_) {
    return StaticParameter.error;
  }

  if (response.statusCode == 500) {
    return StaticParameter.error;
  }

  return response.body.toString();
}

Future<String> httpMultipart(BuildContext context, String filename, String url,
    String path, String accesToken) async {
  var request = http.MultipartRequest('POST', Uri.parse(url))
    ..headers[HttpHeaders.authorizationHeader] = 'Bearer $accesToken';
  request.files.add(await http.MultipartFile.fromPath(filename, path));
  http.Response response = await http.Response.fromStream(await request.send());
  return response.body.toString();
}

Future<String> httpPost(
    String url, Map<String, dynamic> data, String token, int timeout) async {
  var response;
  var urx;
  try {
    urx = Uri.parse(url);
    response = await http
        .post(
          urx,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "x-token": '12345678',
            // HttpHeaders.acceptHeader: 'application/json',
          },
          body: json.encode(
            data,
          ),
        )
        .timeout(
          new Duration(seconds: timeout),
        );
  } on TimeoutException catch (_) {
    return StaticParameter.timeout;
  } on SocketException catch (_) {
    return StaticParameter.error;
  }

  if (response.statusCode == 401 || response.statusCode == 403) {
    await SharedPreferences.getInstance().then((prefs) {
      for (String key in prefs.getKeys()) {
        if (key != "image_path" && key != "email") {
          prefs.remove(key);
        }
      }
    });

    return StaticParameter.redirect;
  }

  if (response.statusCode == 500 || response.statusCode == 503) {
    return response.body;
  }

  if (response.statusCode == 406) {
    try {
      if (json.decode(response.body)['error'].toString() == '406' &&
          json.decode(response.body)['errorCode'].toString() == '100') {
        await SharedPreferences.getInstance().then((prefs) {
          for (String key in prefs.getKeys()) {
            if (key != "image_path") {
              prefs.remove(key);
            }
          }
        });
        return StaticParameter.redirect;
      } else {
        return response.body;
      }
    } catch (_) {
      return StaticParameter.error;
    }
  }

  return response.body.toString();
}

Future<String> httpPostNoToken(
    String url, Map<String, dynamic> data, int timeout) async {
  var response;
  try {
    response = await http
        .post(
          Uri.parse('$url'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode(
            data,
          ),
        )
        .timeout(
          new Duration(seconds: timeout),
        );
  } on TimeoutException catch (_) {
    return StaticParameter.timeout;
  } on SocketException catch (_) {
    return StaticParameter.error;
  }

  if (response.statusCode == 401 || response.statusCode == 403) {
    await SharedPreferences.getInstance().then((prefs) {
      for (String key in prefs.getKeys()) {
        if (key != "image_path" && key != "email") {
          prefs.remove(key);
        }
      }
    });

    return StaticParameter.redirect;
  }

  if (response.statusCode == 500 || response.statusCode == 503) {
    return response.body;
  }

  if (response.statusCode == 406) {
    try {
      if (json.decode(response.body)['error'].toString() == '406' &&
          json.decode(response.body)['errorCode'].toString() == '100') {
        await SharedPreferences.getInstance().then((prefs) {
          for (String key in prefs.getKeys()) {
            if (key != "image_path") {
              prefs.remove(key);
            }
          }
        });
        return StaticParameter.redirect;
      } else {
        return response.body;
      }
    } catch (_) {
      return StaticParameter.error;
    }
  }

  return response.body.toString();
}

Future<String> httpPostUpdate(
    String url, Map<String, dynamic> data, String token, int timeout) async {
  var response;

  try {
    response = await http
        .post(
          Uri.parse('$url'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.acceptHeader: 'application/json',
          },
          body: json.encode(
            data,
          ),
        )
        .timeout(
          new Duration(seconds: timeout),
        );
  } on TimeoutException catch (_) {
    return StaticParameter.timeout;
  } on SocketException catch (_) {
    return StaticParameter.error;
  }

  if (response.statusCode == 401 || response.statusCode == 403) {
    return StaticParameter.redirect;
  }

  if (response.statusCode == 500 || response.statusCode == 503) {
    return response.body;
  }

  return response.body.toString();
}
