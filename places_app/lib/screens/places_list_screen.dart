import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_places_screen.dart';
import '../providers/great_places_provier.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("your places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: Consumer<GreatPlacesProvider>(
        child: Text("No great place for people"),
        builder: (ctx, greatplace, ch) => greatplace.item.length <= 0
            ? ch
            : ListView.builder(
                itemCount: greatplace.item.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatplace.item[i].image),
                  ),
                  title: Text(greatplace.item[i].title),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}
