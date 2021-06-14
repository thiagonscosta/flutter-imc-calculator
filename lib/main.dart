import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _textInfo = "Put your info's";
  double _imc;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _textInfo = "Put your info's";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      _imc = weight / pow(height, 2);

      if (_imc < 18.5) {
        _textInfo = "Thinness";
      } else if (_imc >= 18.5 && _imc <= 24.9) {
        _textInfo = "${_imc.toStringAsPrecision(2)} Normal";
      } else if (_imc >= 25.0 && _imc <= 29.9) {
        _textInfo = "${_imc.toStringAsPrecision(2)} Overweight";
      } else if (_imc >= 30.0 && _imc <= 39.9) {
        _textInfo = "${_imc.toStringAsPrecision(2)} Obesity";
      } else if (_imc >= 40) {
        _textInfo = "${_imc.toStringAsPrecision(2)} Grave Obesity";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IMC Calculator"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline,
                      size: 120.0, color: Colors.blueGrey),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Weight (kg)",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                    controller: weightController,
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Put your weight";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Height (m)",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                    controller: heightController,
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Put your height";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
                    child: Container(
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text("Calculate".toUpperCase()),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            textStyle: TextStyle(fontSize: 18.0)),
                      ),
                    ),
                  ),
                  Text(
                    _textInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                  )
                ],
              ),
            )));
  }
}
