import '../utils/bmi_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

/*
Less than 15	Very severely underweight
Between 15 and 16	Severely underweight
Between 16 and 18.5	Underweight
Between 18.5 and 25	Normal (healthy weight)
Between 25 and 30	Overweight
Between 30 and 35	Moderately obese
Between 35 and 40	Severely obese
Over 40	Very severely obese
 */
String determineBMIMessage(double value) {
  if (value < 15.0){
    return 'Very severely underweight';
  } else if(value >= 15.0 && value< 16.0){
    return 'Severely underweight';
  } else if (value >= 16.0 && value < 18.5) {
    return 'Underweight';
  } else if(value >= 18.5 && value < 25.0){
    return 'Normal (healthy weight)';
  } else if(value >= 25.0 && value < 30.0){
    return 'Overweight';
  } else if(value >= 30.0 && value < 35.0){
    return 'Moderately obese';
  } else if(value >= 35.0 && value < 40.0){
    return 'Severely obese';
  } else if(value >= 40) {
    return 'Very serverely obese';
  } else return '';
}

double calculator(double height, double weight, UnitType uniType) {
    if (height <= 0.0) return 0.0;
    double bmiValue = uniType == UnitType.KilogamMetter? (weight / pow(height/100, 2)) :
      (weight / pow(height, 2) * 703);
    return bmiValue;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}

Future<int> loadValue() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int data = preferences.getInt('data');
  if( data != null ) {
    return data;
  } else {
    return 0;
  }

}

void saveValue(int value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}