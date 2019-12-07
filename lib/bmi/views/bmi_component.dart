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
  
  var _heightController = TextEditingController();
  var _weightController = TextEditingController();
  String _weight, _height;
  var _message = '';
  var _bmiString = '';
  var _value = 0;
  var _heightMessage = '';
  var _weightMessage = '';
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.bmiView = this;
  }

  void handleRadioValueChanged(int value) {
    this.widget.presenter.onOptionChanged(value, heightString: _height, weightString: _weight );
  }

  void _calculator() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      this.widget.presenter.onCalculateClicked(_weight, _height);
    }
    
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
      color: Colors.grey.shade300,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(  
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ageFormField(context),
              heightFormField(context),
              weightFormField(),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: calculateButton()
              ,),
            ],
          ),
        ),
      ),
    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            'Your BMI: $_bmiString',
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
            '$_message',
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
        body: ListView(
          children: <Widget>[
            Image.asset('images/bmilogo.png',
              width: 100.0,
              height: 100.0,)
            ,
            Padding(padding: EdgeInsets.all(5.0)),
            _unitView,
            Padding(padding: EdgeInsets.all(5.0)),
            _mainPartView,
            Padding(padding: EdgeInsets.all(5.0)),
            _resultView
          ],
        )
    );
  }

  RaisedButton calculateButton() {
    return RaisedButton(
      onPressed: _calculator,
      color: Colors.pinkAccent,
      child: Text(
        'Calculate',
        style: TextStyle(fontSize: 16.9),
      ),
      textColor: Colors.white70,
    );
  }

  TextFormField weightFormField() {
    return TextFormField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: _weightFocus,
      onFieldSubmitted: (value){
        _weightFocus.unfocus();
        _calculator();
      },
      validator: (value) {
        if (value.length == 0 || double.parse(value) == 0.0) {
          return ('Weight is not valid. Weight > 0.0');
        }
      }, 
      onSaved: (value) {
        _weight = value;
      },
      decoration: InputDecoration(
          hintText: _weightMessage,
          labelText: _weightMessage,
          icon: Icon(Icons.menu),
          fillColor: Colors.white
      ),
    );
  }

  TextFormField heightFormField(BuildContext context) {
    return TextFormField(
      controller: _heightController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _heightFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _heightFocus, _weightFocus);
      },
      validator: (value) {
        if (value.length == 0 || double.parse(value) == 0.0) {
          return ('Height is not valid. Height > 0.0');
        }
      }, 
      onSaved: (value) {
        _height = value;
      },
      decoration: InputDecoration(
          hintText: _heightMessage,
          icon: Icon(Icons.assessment),
          fillColor: Colors.white,
      ),
    );
  }

  TextFormField ageFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _ageFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _ageFocus, _heightFocus);
      },
      validator: (value) {
        if (value.length == 0 || double.parse(value) <= 15) {
          return ('Age should be over 15 years old');
        }
      }, 
      onSaved: (value) {
      },
      decoration: InputDecoration(
        hintText: 'Age',
        icon: Icon(Icons.person_outline),
        fillColor: Colors.white,
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}
