import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../providers/orders_provider.dart' as ord;
import './../widgets/order_screen/order_item.dart';
import './drawer/main_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/order-screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isloading = true;
      });
      await Provider.of<ord.Orders>(context, listen: false).fetchInitOrders();
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<ord.Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: MainDrawer(),
      body: _isloading
          ? SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(8),
                    child: Text("Here is your orders"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) => OrderItem(orders[index]),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
