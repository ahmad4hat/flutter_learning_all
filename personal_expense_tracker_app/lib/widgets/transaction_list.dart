import 'package:flutter/material.dart';
import './../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTranaction;

  TransactionList(this.transactions, this.deleteTranaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? emptyTransaction() : listsOfTransAction();
  }

  Widget emptyTransaction() {
    return Container(
      height: 400,
      child: Column(
        children: <Widget>[
          Text('No Transaction to show'),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget listsOfTransAction() {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(7),
            child: Card(
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Text(
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Bangers-Regular',
                          color: Theme.of(context).primaryColorDark),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 1.5),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          transactions[index].prettyDate(),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      print(transactions[index].id);
                      deleteTranaction(transactions[index].id);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
