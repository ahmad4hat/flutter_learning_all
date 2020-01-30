import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//provider
import './../providers/cart_provider.dart' show Cart;
import './../providers/orders_provider.dart';

//widgets
import './../widgets/cart_screen/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/CartScreen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Card(
              margin: EdgeInsets.all(18),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$ ${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      // backgroundColor: Theme.of(context).primaryColor) as Color,
                    ),
                    OrderButton(cart: cart)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) => CartItem(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].title,
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        "Order Now",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
      ),
      onPressed: (widget.cart.totalPrice <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalPrice);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
