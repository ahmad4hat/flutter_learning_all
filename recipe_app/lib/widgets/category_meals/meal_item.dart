import 'package:flutter/material.dart';
import './../../screens/meal_details_screen.dart';
import './../../models//meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final complexity;
  final affordability;
  Function removeItem;
  String get complexityText {
    switch (complexity.toString()) {
      case "Complexity.Simple":
        return 'Simple';
      case "Complexity.Hard":
        return 'Hard';
      case "Complexity.Challenging":
        return 'Challenging';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability.toString()) {
      case "Affordability.Affordable":
        return "Affordable";
      case "Affordability.Pricey":
        return "Pricey";
      case "Affordability.Luxurious":
        return "Luxurious";
      default:
        return 'Unknown';
    }
  }

  MealItem(
      {@required this.title,
      @required this.imageUrl,
      @required this.id,
      @required this.duration,
      @required this.complexity,
      @required this.affordability,
      this.removeItem});

  void selectedItem(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetails.routeName, arguments: id)
        .then((res) {
      if (res != null) {
        removeItem(res);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedItem(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.black38,
                    width: 300,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    listBottonDecriptionTextAndIcon(
                        '$duration min', Icon(Icons.schedule)),
                    listBottonDecriptionTextAndIcon(
                        '${complexityText} ', Icon(Icons.work)),
                    listBottonDecriptionTextAndIcon(
                        '${affordabilityText} ', Icon(Icons.monetization_on)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listBottonDecriptionTextAndIcon(String text, Icon icon) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          icon,
          SizedBox(
            width: 10,
          ),
          FittedBox(
            child: Text(
              '$text',
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
