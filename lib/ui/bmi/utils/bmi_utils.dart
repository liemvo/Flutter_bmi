import '../utils/bmi_constant.dart';
import 'dart:math';

String determineBMIMessage(double value) {
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

double calculator(double height, double weight, UnitType uniType) {
    if (height <= 0.0) return 0.0;
    double bmiValue = uniType == UnitType.KilogamMetter? (weight / pow(height, 2)) :
      (weight / pow(height * 12, 2) * 703);
    return bmiValue;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}