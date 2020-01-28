import 'package:flutter/material.dart';
import '../../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildCustomListTile(
      {BuildContext context, Icon icon, String text, Function onTap}) {
    return ListTile(
      leading: icon,
      title: Text(
        '$text',
        style: TextStyle(
            fontFamily: 'Nunito', fontSize: 26, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: 120,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildCustomListTile(
              context: context,
              icon: Icon(Icons.restaurant),
              text: "Meals",
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          _buildCustomListTile(
              context: context,
              icon: Icon(Icons.settings),
              text: "Filters",
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FilterScreen.routeName);
              }),
        ],
      ),
    );
  }
}
