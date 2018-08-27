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

  String get heightMessage => _unitType == UnitType.FeetPound? "Height in feets" : "Height in metters";
  String get weightMessage => _unitType == UnitType.FeetPound? "Weight in pounds" : "Weight in kilogams";
  String get bmiMessage => determineBMIMessage(_bmi);
  BMIViewModel();
}