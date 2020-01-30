import 'package:flutter/material.dart';
import 'package:flutter/material.dart' show required;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite = false;

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
      isFavourite = false});

  bool changeFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
