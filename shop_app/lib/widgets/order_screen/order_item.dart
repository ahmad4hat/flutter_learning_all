import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$ ${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat.yMMMMd().format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Container(
              height: 180,
              padding: EdgeInsets.all(15),
              child: ListView(
                children: <Widget>[
                  ...widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('\$ ${prod.price}'),
                              Text('${prod.quantity} X')
                            ],
                          ))
                      .toList()
                ],
              ),
            )
        ],
      ),
    );
  }
}
