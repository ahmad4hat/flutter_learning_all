import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/orders_provider.dart' show Orders;
import './../widgets/order_screen/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/order-screen";
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8),
              child: Text("Here is your orders"),
            ),
            ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => OrderItem(orders[index].id,
                  orders[index].amount, orders[index].dateTime),
            )
          ],
        ),
      ),
    );
  }
}
