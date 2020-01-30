import 'package:flutter/foundation.dart';

import './cart_provider.dart';
import 'package:http/http.dart' show get, post, patch;
import 'dart:async';
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void fetchInitOrders() async {
    const url = "https://android-flutter-databse.firebaseio.com/orders.json";
    final res = await get(url);
    final List<OrderItem> loadedOrder = [];
    print("fetching orders");
    final extractedData = json.decode(res.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    extractedData.forEach((orderId, orderData) {
      loadedOrder.add(OrderItem(
          id: orderId,
          amount: orderData["amount"],
          dateTime: DateTime.parse(orderData["dateTime"]),
          products: (orderData["products"] as List<dynamic>)
              .map((item) => CartItem.fromMap(item))
              .toList()));
    });
    _orders = loadedOrder.reversed.toList();
    notifyListeners();
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    const url = "https://android-flutter-databse.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();

    final res = await post(
      url,
      body: json.encode(
        {
          "amount": total,
          "dateTime": timeStamp.toIso8601String(),
          "products": [...cartProducts.map((c) => c.toMap).toList()]
        },
      ),
    );
    _orders.insert(
      0, //insert in first item of the list
      OrderItem(
        id: json.decode(res.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
