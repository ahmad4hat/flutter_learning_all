import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show get, post;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId => _userId;

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBNNKSg2ZKg2lJHAIVGbDr-eDO68lZdl-U";

    try {
      final res = await post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final decodedResponse = json.decode(res.body);
      if (decodedResponse["error"] != null) {
        throw Exception(decodedResponse["error"]["message"]);
      }

      _token = decodedResponse["idToken"];
      _userId = decodedResponse["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(decodedResponse["expiresIn"])));

      notifyListeners();
      return Future.value();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signin(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBNNKSg2ZKg2lJHAIVGbDr-eDO68lZdl-U";
    try {
      final res = await post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final decodedResponse = json.decode(res.body);
      if (decodedResponse["error"] != null) {
        throw Exception(decodedResponse["error"]["message"]);
      }

      _token = decodedResponse["idToken"];
      _userId = decodedResponse["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(decodedResponse["expiresIn"])));

      notifyListeners();

      return Future.value();
    } catch (e) {
      throw e;
    }
  }
}
