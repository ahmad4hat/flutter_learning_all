import 'package:flutter/material.dart' show required, ChangeNotifier;

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "quantity": quantity, "price": price};
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;

  double get totalPrice {
    var totalPrice = 0.0;
    _items.forEach(
        (key, value) => {totalPrice += (value.price * value.quantity)});

    return totalPrice;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(prodId) {
    if (!items.containsKey(prodId)) {
      return;
    }
    if (_items[prodId].quantity > 1) {
      _items.update(
        prodId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1),
      );
    } else {
      _items.remove(prodId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
