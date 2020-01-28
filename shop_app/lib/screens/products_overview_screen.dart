import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/common/UI/badge.dart';
//widget
import './../widgets/products_overview_screen/product_item.dart';
import './../widgets/products_overview_screen/products_gridview_builder.dart';

//provider
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

import './cart_sreen.dart';

// model
// import '../providers/product_provider.dart';
enum Filter { Favourite, ShowAll }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var isShowFavourite = false;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "product overview Screen",
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.arrow_drop_down_circle),
            onSelected: (Filter filter) {
              if (filter == Filter.Favourite) {
                setState(() {
                  isShowFavourite = true;
                });
              } else if (filter == Filter.ShowAll) {
                setState(() {
                  isShowFavourite = false;
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("only favourite"),
                value: Filter.Favourite,
              ),
              PopupMenuItem(
                child: Text("show all"),
                value: Filter.ShowAll,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, child) {
              return Badge(
                child: child,
                value: cartData.itemCount.toString(),
              );
            },
            child: IconButton(
              icon: Icon(Icons.developer_board),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: ProductsGridviewBuilder(isShowFavourite),
    );
  }
}
