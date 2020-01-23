import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import './../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTranactionValues =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        double totalSum = 0.0;
        recentTransaction.forEach((transaction) {
          if (transaction.date.day == weekDay.day &&
              transaction.date.month == weekDay.month &&
              transaction.date.year == weekDay.year) {
            totalSum += transaction.amount;
          }
        });

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      }).reversed.toList();
  double get totalSpending =>
      groupedTranactionValues.fold(0.0, (sum, item) => sum + item['amount']);

  @override
  Widget build(BuildContext context) {
    print(groupedTranactionValues);
    return Card(
      elevation: 6.0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ...groupedTranactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
