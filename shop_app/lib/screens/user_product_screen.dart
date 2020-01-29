import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/products_provider.dart';
import '../widgets/user_product_screen/user_product_item.dart';

import './edit_product_screen.dart';

import './drawer/main_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user-product-screen";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Prodoucts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreeen.routeName);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (_, index) => Card(
            child: UserProductItem(products.items[index].id,
                products.items[index].title, products.items[index].imageUrl),
          ),
        ),
      ),
    );
  }
}
