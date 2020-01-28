import 'package:flutter/material.dart';
import './../widgets/category_meals/meal_item.dart';
import './../extra/dummy_data.dart';
import './../models/meal.dart';

class CategotyMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategotyMealsScreenState createState() => _CategotyMealsScreenState();
}

class _CategotyMealsScreenState extends State<CategotyMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      displayMeals = DUMMY_MEALS
          .where((meal) => meal.categories.contains(routeArgs['id']))
          .toList();
    }

    _loadedInitData = true;
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  // CategotyMealsScreen(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: Text(routeArgs['title']),
        backgroundColor: routeArgs['color'],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              id: displayMeals[index].id,
              title: displayMeals[index].title,
              imageUrl: displayMeals[index].imageUrl,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
              duration: displayMeals[index].duration,
              removeItem: _removeMeal);
        },
        itemCount: displayMeals.length,
      ),
    ));
  }
}
