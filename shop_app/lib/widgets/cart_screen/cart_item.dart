import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../providers/cart_provider.dart' show Cart;

class CartItem extends StatelessWidget {
  final price;
  final id;
  final productId;
  final title;
  final quantity;

  CartItem(this.id, this.productId, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(productId),
      onDismissed: (DismissDirection direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
        child: Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(
                child: Text(
                  '\$ ${price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle:
              Text('Total Price : ${(quantity * price).toStringAsFixed(2)}'),
          trailing: Text(' $quantity X'),
        ),
      ),
    );
  }
}
