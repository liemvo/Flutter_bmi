import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }

}

class HomeState extends State<Home>{
  var _ageController = new TextEditingController();
  var _heightController = new TextEditingController();
  var _weightController = new TextEditingController();
  double _bmiValue = 0.0;
  String _bmiMessage = '';

  int radioValue = 0;
  bool isKg = false;
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      isKg = (radioValue==1);
    });
  }
  void _calculator() {
    setState(() {
      if(_heightController.text.isNotEmpty && _weightController.text.isNotEmpty) {
        var height = double.parse(_heightController.text);
        _bmiValue = isKg ?
        (double.parse(_weightController.text) / pow(height, 2)) :
        (double.parse(_weightController.text) / pow(height * 12, 2) * 703);
      } else {
        _bmiValue = 0.0;
      }
      _bmiMessage = _determineBMIMessage(_bmiValue);
    });
  }

  String _determineBMIMessage(double value) {
    if (value < 18.5) {
      return 'Underweight';
    } else if(value >= 18.5 && value <= 24.9){
      return 'Normal';
    } else if(value >= 25.0 && value <= 29.9){
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BMI'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade400,
      ),
      backgroundColor: Colors.white,
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Image.asset('images/bmilogo.png',

              width: 100.0,
              height: 100.0,),
            new Padding(padding: new EdgeInsets.all(5.0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio<int>(
                  activeColor: Colors.blueAccent,
                  value: 0, groupValue: radioValue, onChanged: handleRadioValueChanged,
                ),
                new Text(
                  'Feet & pounds',
                  style: new TextStyle(color: Colors.blueAccent),
                ),
                new Radio<int>(
                  activeColor: Colors.blueAccent,
                  value: 1, groupValue: radioValue, onChanged: handleRadioValueChanged,
                ),
                new Text(
                  'Meters & kilograms',
                  style: new TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
            new Padding(padding: new EdgeInsets.all(5.0)),
            new Container(
              width: 380.0,
              height: 240.0,
              color: Colors.grey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Age',
                        hintText: 'Age',
                        icon: new Icon(Icons.person_outline),
                        fillColor: Colors.white,
                    ),
                  ),
                  new TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: isKg? 'Height in meter':'Height in feet',
                        hintText: isKg? 'Height in meter':'Height in feet',
                        icon: new Icon(Icons.assessment),
                        fillColor: Colors.white
                    ),
                  ),
                  new TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: isKg? 'Weight in kg':'Weight in lb',
                        hintText: isKg? 'Weight in kg':'Weight in lb',
                        icon: new Icon(Icons.menu),
                        fillColor: Colors.white
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(4.5)),
                  new Center(
                    child: new RaisedButton(
                      onPressed: _calculator,
                      color: Colors.pinkAccent,
                      child: new Text(
                        'Calculate',
                        style: new TextStyle(fontSize: 16.9),
                      ),
                      textColor: Colors.white70,
                    ),
                  )
                ],
              ),

            ),
            new Padding(padding: new EdgeInsets.all(5.0)),
            new Column(
              children: <Widget>[
                new Center(
                  child: new Text(
                    'Your BMI: ${_bmiValue.toStringAsFixed(2)}',
                    style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.all(2.0)),
                new Center(
                  child: new Text(
                    '$_bmiMessage',
                    style: new TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}