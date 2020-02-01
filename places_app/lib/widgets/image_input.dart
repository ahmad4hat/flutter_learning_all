import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  Function onSelectedImage;

  ImageInput(this.onSelectedImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    try {
      final _imagefile = await ImagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 600);

      setState(() {
        _storedImage = _imagefile;
      });

      final appDir = await sysPaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(_imagefile.path);
      final savedImage = _imagefile.copy('${appDir.path}/$fileName');
      print("before");
      widget.onSelectedImage(savedImage);
      print("after");
    } catch (err) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("no image"),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text(
              "take picture",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
