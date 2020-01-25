import 'package:flutter/material.dart';
import './../widgets/category_meals/meal_item.dart';
import './../extra/dummy_data.dart';

class CategotyMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String id;
  // final String title;
  // final Color color;

  // CategotyMealsScreen(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(routeArgs['id']))
        .toList();
    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: Text(routeArgs['title']),
        backgroundColor: routeArgs['color'],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
            duration: categoryMeals[index].duration,
          );
        },
        itemCount: categoryMeals.length,
      ),
    ));
  }
}
