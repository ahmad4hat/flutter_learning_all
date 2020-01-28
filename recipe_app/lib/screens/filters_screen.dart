import 'package:flutter/material.dart';
import '../widgets/drawer/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "/filter-screen";

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _vegan = false;
  var _glutinFree = false;
  var _vg = false;
  var _lactosFree = false;

  Widget _buildCustomSwitchTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("filters"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Text("Change Your flilter"),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildCustomSwitchTile(
                    "glutinFree", "Have glutin free meal", this._glutinFree,
                    (newValue) {
                  setState(() {
                    _glutinFree = newValue;
                  });
                }),
                _buildCustomSwitchTile(
                    "lactosFree", "Have glutin free meal", this._lactosFree,
                    (newValue) {
                  setState(() {
                    _lactosFree = newValue;
                  });
                }),
                _buildCustomSwitchTile("vg", "Have glutin free meal", this._vg,
                    (newValue) {
                  setState(() {
                    _vg = newValue;
                  });
                }),
                _buildCustomSwitchTile(
                    "vegan", "Have glutin free meal", this._vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
