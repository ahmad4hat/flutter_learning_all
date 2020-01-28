import 'package:flutter/material.dart';
import './../extra/dummy_data.dart';
import 'dart:async';

class MealDetails extends StatelessWidget {
  static const routeName = "/meal-details";

  buildTitleText(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '$text',
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  buildCustomContainer({BuildContext context, Widget child}) {
    return Container(
        height: 200,
        width: 300,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    void poped() {
      Navigator.pop(context, mealId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTitleText(context, 'Ingredient'),
            buildCustomContainer(
              context: context,
              child: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      child: Text(
                        selectedMeal.ingredients[index],
                      ),
                    ),
                  );
                },
              ),
            ),
            buildTitleText(context, 'Steps'),
            buildCustomContainer(
              context: context,
              child: ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_outline),
        onPressed: () async {
          await print(mealId.runtimeType);
          poped();
        },
      ),
    );
  }
}
