import 'package:flutter/material.dart';
import 'package:flutter/material.dart' show required;
import 'package:http/http.dart' show put;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  var isFavourite;

  Map<String, Object> get toMap => {
        "title": title,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
        "isFavourite": isFavourite
      };

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});

  void changeFavourite(String authToken, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url =
        'https://android-flutter-databse.firebaseio.com/userFavourite/$userId/$id.json?auth=$authToken';

    try {
      final res =
          await put(url, body: json.encode({"isFavourite": isFavourite}));
      if (res.statusCode >= 400) {
        throw Exception("something went wrong while updating the favourite");
      }
    } catch (error) {
      print(error);
      isFavourite = oldStatus;
    }

    notifyListeners();
  }
}
