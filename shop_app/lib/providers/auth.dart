import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show get, post;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  var pref;

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

      _autoLogout();

      print("------------");
      pref = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      notifyListeners();
      pref.setString('userData', userData);
      print("------------");
      print(pref.getString('userData'));
      return Future.value();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    print("auto login begain");
    print("auto loging middle1");
    pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }
    print("auto loging middle");

    final extractedUserData = json.decode(pref.getString('userData'));
    print(extractedUserData);
    final expiryDate = DateTime.parse(extractedUserData["expiryDate"]);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData["token"];
    _userId = extractedUserData["userId"];
    _expiryDate = expiryDate;
    _autoLogout();
    print("auto login end");
    notifyListeners();
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

      _autoLogout();
      print("------------");
      pref = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      notifyListeners();
      pref.setString('userData', userData);
      print("------------");
      print(pref.getString('userData'));
      notifyListeners();

      return Future.value();
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    pref = await SharedPreferences.getInstance();
    _token = null;
    _userId = null;
    _expiryDate = null;
    await pref.clear();

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    print("auto logout");
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    var timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
