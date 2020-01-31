import 'package:flutter/material.dart';
import './product_provider.dart';
import 'package:http/http.dart' show get, post, patch, delete;
import 'dart:async';
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  String _authToken;
  String _userId;
  List<Product> _items = [];

  ProductsProvider(this._authToken, this._userId, this._items);

  List<Product> get favoutires =>
      _items.where((prod) => prod.isFavourite == true).toList();

  List<Product> get items => [..._items];

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  Future<void> getInitProducts([bool filterByUser = false]) async {
    final String filterByUserString =
        filterByUser == true ? 'orderBy="creatorId"&equalTo="$_userId"' : '';

    // print(' prod ---- $filterByUserString');
    print(_userId);
    final url =
        'https://android-flutter-databse.firebaseio.com/products.json?auth=$_authToken&$filterByUserString';
    print("fetchig Products");
    try {
      final res = await get(url);

      final urlForFav =
          'https://android-flutter-databse.firebaseio.com/userFavourite/$_userId.json?auth=$_authToken';

      final favRes = await get(urlForFav);
      final favData = json.decode(favRes.body);

      final produtcsData = json.decode(res.body) as Map<String, dynamic>;
      if (produtcsData == null) return;
      List<Product> prodItems = [];
      produtcsData.forEach((key, value) {
        prodItems.add(Product(
          id: key,
          description: value["description"],
          isFavourite: favData == null
              ? false
              : favData['$key'] == null
                  ? false
                  : favData['$key']["isFavourite"] ?? false,
          price: value["price"],
          title: value["title"],
          imageUrl: value["imageUrl"],
        ));

        print(favData);
      });
      _items = prodItems;
    } catch (error) {
      print(error);
    }
    notifyListeners();
    // return Future.value();
  }

  Future<void> addProduct(product) async {
    final url =
        'https://android-flutter-databse.firebaseio.com/products.json?auth=$_authToken';

    try {
      final res = await post(url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavourite": product.isFavourite,
            "creatorId": _userId
          }));
      final newProduct = Product(
        title: product.title,
        imageUrl: product.imageUrl,
        price: product.price,
        description: product.description,
        id: json.decode(res.body)['name'],
      );
      _items.add(newProduct);
    } catch (error) {
      throw new Exception("Somethin went wrong while adding the data");
    }

    notifyListeners();
    return Future.value();
  }

  void updateProduct(productId, newProduct) async {
    final url =
        'https://android-flutter-databse.firebaseio.com/products/$productId.json?auth=$_authToken';

    await patch(url, body: json.encode(newProduct.toMap));

    int index = _items.indexWhere((prod) => prod.id == productId);
    _items[index] = newProduct;

    notifyListeners();
  }

  void removeProduct(String id) async {
    final url =
        'https://android-flutter-databse.firebaseio.com/products/$id.json?auth=$_authToken';
    try {
      final res = await delete(url);
      if (res.statusCode >= 400) {
        throw Exception("Can not delete that product");
      }
      _items.removeWhere((prod) => prod.id == id);
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }
}
