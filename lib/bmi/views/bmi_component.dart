import 'package:flutter/material.dart';

import '../viewmodel/bmi_viewmodel.dart';
import '../views/bmi_view.dart';
import '../presenter/bmi_presenter.dart';

class HomePage extends StatefulWidget {
  final BMIPresenter presenter;

  HomePage(this.presenter, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements BMIView {
  BMIViewModel _viewModel;
  var _ageController = new TextEditingController();
  var _heightController = new TextEditingController();
  var _weightController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.bmiView = this;

  }

  void handleRadioValueChanged(int value) {
    this.widget.presenter.onOptionChanged(value, heightString: _heightController.text, weightString: _weightController.text );
  }

  void _calculator() {
    this.widget.presenter.onCalculateClicked(_weightController.text, _heightController.text);
  }

  @override
  void updateView(BMIViewModel viewModel) {
    setState(() {
      _viewModel = viewModel;

      _heightController.text = _viewModel.heightInString;
      _weightController.text = _viewModel.weightInString;

    });
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
                    value: 0, groupValue: _viewModel.value, onChanged: handleRadioValueChanged,
                  ),
                  new Text(
                    'Feet & pounds',
                    style: new TextStyle(color: Colors.blueAccent),
                  ),
                  new Radio<int>(
                    activeColor: Colors.blueAccent,
                    value: 1, groupValue: _viewModel.value, onChanged: handleRadioValueChanged,
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
                          labelText: _viewModel.heightMessage,
                          hintText: _viewModel.heightMessage,
                          icon: new Icon(Icons.assessment),
                          fillColor: Colors.white,
                      ),
                    ),
                    new TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: _viewModel.weightMessage,
                          hintText: _viewModel.weightMessage,
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
                      'Your BMI: ${_viewModel.bmiInString}',
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
                      '${_viewModel.bmiMessage}',
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
