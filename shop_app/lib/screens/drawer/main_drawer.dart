import 'package:flutter/material.dart';
import './../order_screen.dart';
import './../user_product_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Text("I am a big Drawer"),
            ),
            Divider(),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Product"),
              onTap: () => {Navigator.of(context).pushReplacementNamed('/')},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Orders"),
              onTap: () => {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName)
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mode_edit),
              title: Text("User Products"),
              onTap: () => {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName)
              },
            ),
          ],
        ),
      ),
    );
  }
}
