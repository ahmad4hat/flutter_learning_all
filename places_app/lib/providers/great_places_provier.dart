import 'dart:io';
import 'package:flutter/material.dart' show ChangeNotifier;
import './../models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get item => [..._items];

  addPlace(String pickedTitle, File pickedImage) {
    print("Adding Image");
    final Place newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
  }
}
