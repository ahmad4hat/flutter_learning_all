import 'package:flutter/material.dart';
//widget
import './../widgets/products_overview_screen/product_item.dart';
import './../widgets/products_overview_screen/products_gridview_builder.dart';

// model
// import '../providers/product_provider.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "product overview Screen",
        ),
      ),
      body: ProductsGridviewBuilder(),
    );
  }
}
