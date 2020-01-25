import 'package:flutter/material.dart';
import './screens/categories_screen.dart';
import './screens/categoty_meals_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 244, 223, 1),
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 1, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 1, 1),
              ),
              title: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
      ),
      home: TabsScreen(),
      routes: {
        CategotyMealsScreen.routeName: (context) => CategotyMealsScreen(),
        MealDetails.routeName: (context) => MealDetails()
      },
      onUnknownRoute: (setting) =>
          MaterialPageRoute(builder: (ctx) => CategoriesScreen()),
    );
  }
}
