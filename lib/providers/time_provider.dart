import 'package:flutter/material.dart';

import '../util/colors.dart';

class ThemeModel with ChangeNotifier {
  late TimeOfDay _timeOfDay;
  late Color _appcolor;
  late String _greeting;

  ThemeModel() {
    _timeOfDay = TimeOfDay.now();
    _updateTheme();
  }

  TimeOfDay get timeOfDay => _timeOfDay;
  Color get appcolor => _appcolor;
  String get greeting => _greeting;

  void updateTime(TimeOfDay time) {
    _timeOfDay = time;
    _updateTheme();
  }

  void _updateTheme() {
    if (_timeOfDay.hour < 6 && _timeOfDay.hour > 18) {
      // for night
      _appcolor = AppColor.fancyDark;
      _greeting = 'Good Night';
    } else if (_timeOfDay.hour < 12) {
      // For morning
      _appcolor = AppColor.fancyWhite;
      _greeting = 'Good Morning';
    } else {
      // Afternoon
      _appcolor = AppColor.fancyWhite;
      _greeting = 'Good afternoon';
    }
    notifyListeners();
  }
}
