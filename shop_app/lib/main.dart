import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import './providers/products_provider.dart';
import './providers/cart_provider.dart';

//screens
import './screens/products_overview_screen.dart';
import './screens/product_details_screen.dart';
import './screens/cart_sreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.deepOrange,
          fontFamily: 'Nunito',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen()
        },
      ),
    );
  }
}
