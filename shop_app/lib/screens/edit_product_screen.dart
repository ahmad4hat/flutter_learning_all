import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import './../providers/product_provider.dart';
import './../providers/products_provider.dart';
import './../screens/user_product_screen.dart';

class EditProductScreeen extends StatefulWidget {
  static const routeName = "/edit-product";
  @override
  _EditProductScreeenState createState() => _EditProductScreeenState();
}

class _EditProductScreeenState extends State<EditProductScreeen> {
  final _priceFocosNode = FocusNode();
  final _decriptionFocosNode = FocusNode();
  final _imageurlFocosNode = FocusNode();
  final _imageurlController = TextEditingController();
  final _from = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', price: 0.0, description: '', imageUrl: '');

  var isInit = true;
  var _intiValue = {
    "title": '',
    "description": '',
    "price": '',
    "imageUrl": '',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageurlFocosNode.addListener(_urlImageUpdate);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final productId = ModalRoute.of(context).settings.arguments;
    if (productId != null) {
      _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
          .findById(productId);

      _intiValue = {
        "title": _editedProduct.title,
        "description": _editedProduct.description,
        "price": _editedProduct.price.toString(),
        "imageUrl": '',
      };
      _imageurlController.text = _editedProduct.imageUrl;
    }
    isInit = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocosNode.dispose();
    _decriptionFocosNode.dispose();
    _imageurlFocosNode.dispose();
    _imageurlController.dispose();
  }

  void _urlImageUpdate() {
    if (!_imageurlFocosNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    print("save form was clicked");
    final validity = _from.currentState.validate();

    if (!validity) {
      return;
    }
    _from.currentState.save();

    if (_editedProduct.id == null) {
      var a = Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct);
    } else {
      var b = Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    }

    //Navigator.of(context).pushNamed(UserProductScreen.routeName);
    Navigator.pop(context);
    //Navigator.of(context).pop();
    // print("stuff");
    // print(_editedProduct.toMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _from,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _intiValue["title"],
                decoration: InputDecoration(
                  labelText: "title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocosNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Title is empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price);
                },
              ),
              TextFormField(
                initialValue: _intiValue["price"],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price"),
                focusNode: _priceFocosNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_decriptionFocosNode),
                validator: (value) {
                  if (value.isEmpty) {
                    return "price is empty";
                  } else if (double.tryParse(value) == null) {
                    return "value is not a number";
                  } else if (double.parse(value) < 0.5) {
                    return "Number is too small";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: double.parse(value),
                  );
                },
              ),
              TextFormField(
                initialValue: _intiValue["description"],
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                focusNode: _decriptionFocosNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Description is empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Theme.of(context).primaryColor)),
                    child: _imageurlController.text.isEmpty
                        ? Text("please enter a valid url")
                        : FittedBox(
                            child: Image.network(
                              _imageurlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      controller: _imageurlController,
                      focusNode: _imageurlFocosNode,
                      textInputAction: TextInputAction.done,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          imageUrl: value,
                          price: _editedProduct.price,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Image Url is empty";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _saveForm(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
