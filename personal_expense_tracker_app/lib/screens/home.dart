import 'package:flutter/material.dart';

// widgets
import './../models/transaction.dart';
import './../widgets/transaction_list.dart';
import './../widgets/new_transaction.dart';
import './../widgets/chart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> transactions = [
    // Transaction(id: 't1', title: 'food', amount: 69.9, date: DateTime.now()),
    // Transaction(id: 't2', title: 'soda', amount: 64.9, date: DateTime.now()),
    // Transaction(id: 't3', title: 'lpen', amount: 89.9, date: DateTime.now()),
    // Transaction(id: 't1', title: 'food', amount: 69.9, date: DateTime.now()),
    // Transaction(id: 't2', title: 'soda', amount: 64.9, date: DateTime.now()),
    // Transaction(id: 't3', title: 'lpen', amount: 89.9, date: DateTime.now()),
    // Transaction(id: 't1', title: 'food', amount: 69.9, date: DateTime.now()),
    // Transaction(id: 't2', title: 'soda', amount: 64.9, date: DateTime.now()),
    // Transaction(id: 't3', title: 'lpen', amount: 89.9, date: DateTime.now()),
  ];

  bool showCharts = false;

  List<Transaction> get recentTransaction => transactions.where((tx) {
        return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();

  void addTransaction(String title, double amount, DateTime date) {
    setState(() {
      transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(child: NewTransaction(addTransaction));
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    bool isLandcape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Personal expense trucker"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );

    var txtlist = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(transactions, deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandcape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show chart'),
                  Switch(
                    value: showCharts,
                    onChanged: (val) {
                      setState(() {
                        showCharts = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandcape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(recentTransaction)),
            if (!isLandcape) txtlist,
            if (isLandcape)
              showCharts
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(recentTransaction))
                  : txtlist
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
