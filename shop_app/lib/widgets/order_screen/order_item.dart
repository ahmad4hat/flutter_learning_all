import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final id, amount, date;
  OrderItem(this.id, this.amount, this.date);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${amount.tostringasfixed(2)}'),
        subtitle: Text(DateFormat.yMMMMd().format(date)),
      ),
    );
  }
}
