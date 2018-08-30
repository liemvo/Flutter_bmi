import '../utils/bmi_constant.dart';
import '../utils/bmi_utils.dart';
class BMIViewModel {
  double _bmi = 0.0;
  UnitType _unitType = UnitType.FeetPound;

  double height;
  double weight;

  double get bmi => _bmi;
  set bmi(double outBMI){
    _bmi = outBMI;
  }

  UnitType get unitType => _unitType;
  set unitType(UnitType setValue){
    _unitType = setValue;
  }

  int get value => _unitType == UnitType.FeetPound?0 : 1;
  set value(int value){
    _unitType = value == 0? UnitType.FeetPound: UnitType.KilogamMetter;
  }

  String get heightMessage => _unitType == UnitType.FeetPound? "Height in inch" : "Height in cm";
  String get weightMessage => _unitType == UnitType.FeetPound? "Weight in pound" : "Weight in kg";
  String get bmiMessage => determineBMIMessage(_bmi);
  String get bmiInString => bmi.toStringAsFixed(2);
  String get heightInString => height != null ? height.toString():'';
  String get weightInString => weight != null ? weight.toString():'';

  BMIViewModel();
}