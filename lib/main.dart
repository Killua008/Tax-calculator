import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Tax Calculator',
    home: Tax(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        accentColor: Colors.lightGreenAccent),
  ));
}

class Tax extends StatefulWidget {
  @override
  _TaxState createState() => _TaxState();
}

class _TaxState extends State<Tax> {
  // final _minimumPadding = 5.0;
  TextEditingController costController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  //TextEditingController costcontrol = TextEditingController();

  var display = '';
  double cost = 0.0;
  double tax = 0.0;
  double amount = 0.0;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Tax Calculator'),
      ),
      body: Container(
        height: 800,
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: costController,
                  decoration: InputDecoration(
                      labelText: 'Cost',
                      hintText: 'Cost of Product',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: taxController,
                    decoration: InputDecoration(
                        labelText: 'Tax',
                        hintText: 'Tax of Product in Percentage',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ))
                ])),
            Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Tax Inclusive'),
                        onPressed: () {
                          setState(() {
                            this.display = _calTaxInclusive();
                          });
                        }),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Tax Exclusive'),
                        onPressed: () {
                          setState(() {
                            this.display = _calTaxExclusive();
                          });
                        }),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Reset'),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        }),
                  ),
                ])),
            Padding(
              padding: EdgeInsets.all(5.0 * 2),
              child: Text(this.display, style: textStyle),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/tax.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(50.0),
    );
  }

  String _calTaxInclusive() {
    double cost = double.parse(costController.text);
    double tax = double.parse(taxController.text);
    try {
      double amount =
          double.parse(((cost * tax) / (tax + 100)).toStringAsFixed(2));
      String result =
          'Tax amount(Included) : $amount INR \n Amount payable : $cost INR';
      return result;
    } catch (e) {
      return e;
    }
  }

  String _calTaxExclusive() {
    double cost = double.parse(costController.text);
    double tax = double.parse(taxController.text);
    try {
      double amount =
          double.parse((cost + (cost * tax) / 100).toStringAsFixed(2));
      String result = 'Total amount payable : $amount INR \n Tax : $tax %';
      return result;
    } catch (e) {
      return e;
    }
  }

  void _reset() {
    costController.text = '';
    taxController.text = '';
    display = '';
  }
}
