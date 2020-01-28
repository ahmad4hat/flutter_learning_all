import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favourite_screen.dart';
import './../widgets/drawer/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [
    {"page": CategoriesScreen(), "title": "Categories"},
    {"page": FavouriteScreen(), "title": "Favorite"}
  ];

  int _selectedIndex = 0;

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]["title"]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _setSelectedIndex,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        // fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context)
                  .primaryColor, // you have to add seperate background color for each item for BottomNavigationBarType.shifting,
              icon: Icon(Icons.category),
              title: Text("Category")),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text("Favourite")),
        ],
      ),
    );
  }
}
