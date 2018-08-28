import '../views/bmi_view.dart';
import '../viewmodel/bmi_viewmodel.dart';
import '../utils/bmi_constant.dart';
import '../utils/bmi_utils.dart';
import 'dart:async';

class BMIPresenter {
  void onCalculateClicked(String weightString, String heightString){

  }

  void onOptionChanged(int value, {String weightString, String heightString}) {

  }

  set bmiView(BMIView value){}

}

class BasicBMIPresenter implements BMIPresenter{
  BMIViewModel _viewModel;
  BMIView _view;

  BasicBMIPresenter() {
    this._viewModel = BMIViewModel();
    _loadUnit();
  }

  void _loadUnit() async{
    _viewModel.value = await loadValue();
    _view.updateView(_viewModel);
  }

  @override
  set bmiView(BMIView value) {
    _view = value;
    _view.updateView(_viewModel);
  }

  @override
  void onCalculateClicked(String weightString, String heightString) {
    var height = 0.0;
    var weight = 0.0;
    try {
      height = double.parse(heightString);
    } catch (e){

    }
    try {
      weight = double.parse(weightString);
    } catch (e) {

    }
    _viewModel.height = height;
    _viewModel.weight = weight;
    _viewModel.bmi = calculator(height, weight, _viewModel.unitType);
    _view.updateView(_viewModel);
  }

  @override
  void onOptionChanged(int value, {String weightString, String heightString})  {


    if (value != _viewModel.value) {
      _viewModel.value = value;
      saveValue(_viewModel.value);
      var height;
      var weight;
      if (!isEmptyString(heightString)) {
        try {
          height = double.parse(heightString);
        } catch (e) {

        }
      }
      if (!isEmptyString(weightString)) {
        try {
          weight = double.parse(weightString);
        } catch (e) {

        }
      }

      if (_viewModel.unitType == UnitType.FeetPound) {
        if (weight != null) _viewModel.weight =  weight * 2.2046226218;
        if (height != null) _viewModel.height =  height * 3.28084;
      } else {
        if (weight != null) _viewModel.weight =  weight / 2.2046226218;
        if (height != null) _viewModel.height =  height / 3.28084;
      }

      _view.updateView(_viewModel);
    }
  }
}