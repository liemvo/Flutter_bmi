import 'package:flutter/material.dart';
import 'ui/bmi/views/bmi_component.dart';
import 'ui/bmi/presenter/bmi_presenter.dart';
void main(){
  runApp(
    new MaterialApp(
      title: 'BMI',
      home: new HomePage(new BasicBMIPresenter()),
    )
  );
}
