import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product-details";
  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    String id = map["id"];
    String url = map["url"];

    final product = Provider.of<ProductsProvider>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 300,
                width: double.infinity,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                product.description,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text('\$ ${product.price}')
            ],
          ),
        ),
      ),
    );
  }
}
