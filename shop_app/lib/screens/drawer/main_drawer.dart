import 'package:flutter/material.dart';
import './../order_screen.dart';

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
            FlatButton(
              child: Text("orders"),
              onPressed: () => {
                Navigator.of(context).
              },
            ),
            FlatButton(
              child: Text("Products"),
              onPressed: () => {

              },
            ),
            FlatButton(
              child: Text("orders"),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
