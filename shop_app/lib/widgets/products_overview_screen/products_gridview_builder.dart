import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../providers/products_provider.dart';
import './../../providers/product_provider.dart';
import './product_item.dart';

class ProductsGridviewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context) as ProductsProvider;
    final list = productsProvider.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: list.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
          create: (context) => list[index], child: ProductItem()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
    );
  }
}
