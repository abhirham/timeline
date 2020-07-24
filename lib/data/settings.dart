import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum timeTravel { Forward, Backward }

class Settings with ChangeNotifier {
  bool useInputScreen = false,
      hideInputScreen = false,
      timeTravelling = false,
      _showInputScreen = false;
  timeTravel mode = timeTravel.Forward;
  String extraMins = "0", screenShotPath, clockDownScreenShotPath;
  DateTime _now = DateTime.now();
  int _timeToAdd = 0;

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  Settings() {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        DateTime currentTime = DateTime.now();

        if (currentTime.difference(_now).inSeconds > 0) {
          _now = currentTime;
          notifyListeners();
        }
      },
    );
  }

  void setUseInputScreen(bool val) {
    useInputScreen = val;
    if (!val) hideInputScreen = false;
    notifyListeners();
  }

  void setHideInputScreen(bool val) {
    hideInputScreen = val;
    notifyListeners();
  }

  void setMode(timeTravel val) {
    mode = val;
    notifyListeners();
  }

  void setExtraMins(String val) {
    extraMins = val;
    notifyListeners();
  }

  get time => DateFormat.Hm().format(timeTravelling ? timeTravelTime : _now);

  get dateAndMonth =>
      DateFormat('EEE, MMM d').format(timeTravelling ? timeTravelTime : _now);

  set setTimeToAdd(int num) {
    _timeToAdd = num;
  }

  get showInputScreen => _showInputScreen;

  set showInputScreen(bool val) {
    _showInputScreen = val;
    notifyListeners();
  }

  void setScreenShot(String path) {
    screenShotPath = path;
    notifyListeners();
  }

  void setClockDownScreenShot(String path) {
    clockDownScreenShotPath = path;
    notifyListeners();
  }

  get timeTravelTime => _now.add(Duration(minutes: _timeToAdd));

  void prepMagic() {
    timeTravelling = true;
    _showInputScreen = false;
    notifyListeners();
  }

  void _startTimeTravel() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (_timeToAdd > 0) {
        _timeToAdd--;
        notifyListeners();
      } else {
        timeTravelling = false;
        timer.cancel();
      }
    });
  }

  void startTimeTravel() {
    if (!timeTravelling) return;
    Timer(Duration(seconds: 3), () => _startTimeTravel());
  }

  Future<void> getData() async {
    SharedPreferences pref = await _pref;
    print('fetching data');
    useInputScreen = pref.getBool('useInputScreen') ?? useInputScreen;
    hideInputScreen = pref.getBool('hideInputScreen') ?? hideInputScreen;
    mode = pref.getString('mode') != null
        ? timeTravel.values
            .firstWhere((e) => e.toString() == pref.getString('mode'))
        : mode;
    extraMins = pref.getString('extraMins') ?? extraMins;
    screenShotPath = pref.getString('screenShot');
    clockDownScreenShotPath = pref.getString('clockDownScreenShot');
    notifyListeners();
    return;
  }

  void saveData() async {
    SharedPreferences pref = await _pref;

    pref.setBool('useInputScreen', useInputScreen);
    pref.setBool('hideInputScreen', hideInputScreen);
    pref.setString('mode', mode.toString());
    pref.setString('extraMins', extraMins);
    pref.setString('screenShot', screenShotPath);
    pref.setString('clockDownScreenShot', clockDownScreenShotPath);
  }
}
