import '../views/bmi_view.dart';
import '../viewmodel/bmi_viewmodel.dart';
import '../utils/bmi_constant.dart';
import '../utils/bmi_utils.dart';

class BMIPresenter {
  void onCalculateClicked(String weightString, String heightString){

  }
  void onOptionChanged(int value, {String weightString, String heightString}) {

  }
  set bmiView(BMIView value){}

  void onAgeSubmitted(String age){}
  void onHeightSubmitted(String height){}
  void onWeightSubmitted(String weight){}
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
    _view.updateUnit(_viewModel.value, _viewModel.heightMessage, _viewModel.weightMessage);
  }

  @override
  set bmiView(BMIView value) {
    _view = value;
    _view.updateUnit(_viewModel.value, _viewModel.heightMessage, _viewModel.weightMessage);
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
    _view.updateBmiValue(_viewModel.bmiInString, _viewModel.bmiMessage);
  }

  @override
  void onOptionChanged(int value, {String weightString, String heightString})  {

    final weightScale = 2.2046226218;
    final heightScale = 2.54;

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
        if (weight != null) _viewModel.weight =  weight * weightScale;
        if (height != null) _viewModel.height =  height / heightScale;
      } else {
        if (weight != null) _viewModel.weight =  weight / weightScale;
        if (height != null) _viewModel.height =  height * heightScale;
      }

      _view.updateUnit(_viewModel.value, _viewModel.heightMessage, _viewModel.weightMessage);
      _view.updateHeight(height: _viewModel.heightInString);
      _view.updateWeight(weight: _viewModel.weightInString);
    }
  }

  @override
  void onAgeSubmitted(String age) {
    // TODO: will implement late
  }

  @override
  void onHeightSubmitted(String height) {
    try {
      _viewModel.height = double.parse(height);
    } catch (e){

    }
  }

  @override
  void onWeightSubmitted(String weight) {
    try {
      _viewModel.weight = double.parse(weight);
    } catch (e){

    }
  }
}