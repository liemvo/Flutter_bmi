import 'package:flutter/material.dart';
import 'bmi/views/bmi_component.dart';
import 'bmi/presenter/bmi_presenter.dart';
void main(){
  runApp(
    new MaterialApp(
      title: 'BMI',
      home: new HomePage(new BasicBMIPresenter()),
    )
  );
}
