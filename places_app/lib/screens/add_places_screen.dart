import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../widgets/image_input.dart';

import '../providers/great_places_provier.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/addPlaceRouteName";
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File _pickedImage;

  void _selectedImage(File pickedImage) {
    print("saved image");
    setState(() {
      _pickedImage = pickedImage;
    });

    print("saved image");
  }

  void _savePlace() {
    print("add was clicked");
    if (_titleController.text == '' || _pickedImage == null) {
      print(_titleController.text);
      if (_pickedImage == null) print("isEmpty");
      return;
    }
    Provider.of<GreatPlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add places"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectedImage)
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Add place"),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
