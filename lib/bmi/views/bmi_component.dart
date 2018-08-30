import 'package:flutter/material.dart';
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
  //BMIViewModel _viewModel;
  var _ageController = TextEditingController();
  var _heightController = TextEditingController();
  var _weightController = TextEditingController();
  var _message = '';
  var _bmiString = '';
  var _value = 0;
  var _heightMessage = '';
  var _weightMessage = '';
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();

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
  void updateBmiValue(String bmiValue, String bmiMessage){
    setState(() {
      _bmiString = bmiValue;
      _message = bmiMessage;
    });
  }
  @override
  void updateWeight({String weight}){
    setState(() {
      _weightController.text = weight != null?weight:'';
    });
  }
  @override
  void updateHeight({String height}){
    setState(() {
      _heightController.text = height != null?height:'';
    });
  }
  @override
  void updateUnit(int value, String heightMessage, String weightMessage){
    setState(() {
      _value = value;
      _heightMessage = heightMessage;
      _weightMessage = weightMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _unitView = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: Colors.lightBlue,
          value: 0, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Imperial Unit',
          style: TextStyle(color: Colors.blue),
        ),
        Radio<int>(
          activeColor: Colors.lightBlue,
          value: 1, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Metric Unit',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );

    var _mainPartView = Container(
      width: 380.0,
      height: 240.0,
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: _ageFocus,
            onFieldSubmitted: (term){
              _fieldFocusChange(context, _ageFocus, _heightFocus);
            },
            decoration: InputDecoration(
              labelText: 'Age',
              hintText: 'Age',
              icon: Icon(Icons.person_outline),
              fillColor: Colors.white,
            ),
          ),
          TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: _heightFocus,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _heightFocus, _weightFocus);
            },
            decoration: InputDecoration(
                labelText: _heightMessage,
                hintText: _heightMessage,
                icon: Icon(Icons.assessment),
                fillColor: Colors.white,
            ),
          ),
          TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            focusNode: _weightFocus,
            onFieldSubmitted: (value){
              _weightFocus.unfocus();
              _calculator();
            },
            decoration: InputDecoration(
                labelText: _weightMessage,
                hintText: _weightMessage,
                icon: Icon(Icons.menu),
                fillColor: Colors.white
            ),
          ),
          Padding(padding: EdgeInsets.all(4.5)),
          Center(
            child: RaisedButton(
              onPressed: _calculator,
              color: Colors.pinkAccent,
              child: Text(
                'Calculate',
                style: TextStyle(fontSize: 16.9),
              ),
              textColor: Colors.white70,
            ),
          )
        ],
      ),
    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            'Your BMI: ${_bmiString}',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(2.0)),
        Center(
          child: Text(
            '${_message}',
            style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24.0,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent.shade400,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: <Widget>[
              Image.asset('images/bmilogo.png',
                width: 100.0,
                height: 100.0,),
              Padding(padding: EdgeInsets.all(5.0)),
              _unitView,
              Padding(padding: EdgeInsets.all(5.0)),
              _mainPartView,
              Padding(padding: EdgeInsets.all(5.0)),
              _resultView
            ],
          ),
        )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}
