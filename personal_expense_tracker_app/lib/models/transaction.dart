import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' show DateFormat;

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});

  String prettyDate() {
    return DateFormat.yMMMd().format(this.date);
  }
}
