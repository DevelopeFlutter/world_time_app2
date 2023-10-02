// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:flutter/cupertino.dart';
class CounterProvider extends ChangeNotifier{
  CounterProvider();
  var _count = 0;
  int get count => _count;
  void increment(){
    _count++;
    notifyListeners();
  }

}
class timerProvider extends ChangeNotifier{
  timerProvider();
  var countdown = 60;
  Timer? _timer;
  bool get isActive => _timer?.isActive ?? false;
  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (countdown == 0) {
        _timer?.cancel();
        notifyListeners();
        return;
      }
      countdown--;
      notifyListeners();
    });
  }
  void stop(){
    _timer?.cancel();
    notifyListeners();
  }

}