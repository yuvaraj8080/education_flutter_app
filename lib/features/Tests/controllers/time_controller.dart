
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';



class TimerController extends GetxController {

 VoidCallback onFinish;
  TimerController({required this.onFinish});
  final RxInt _duration = 0.obs;
  final RxInt _startTime = 0.obs;
  final RxBool _isTimerRunning = false.obs;
  Timer? _timer;

  int get duration => _duration.value;
  int get startTime => _startTime.value;
  bool get isTimerRunning => _isTimerRunning.value;

  void startTimer(int duration) {
    _duration.value = duration;
    _startTime.value = DateTime.now().millisecondsSinceEpoch;
    _isTimerRunning.value = true;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (_duration.value < 1) {
        t.cancel();
        _isTimerRunning.value = false;
        onFinish();
      } else {
        _duration.value--;
        update();
      }
    });
  }
  void stopTimer() {
    if (_timer!= null) {
    _timer!.cancel();
    _isTimerRunning.value = false;
    print('Timer stopped');
  } else {
    print('Timer is null');
  }
  }

  void resetTimer() {
    _duration.value = startTime;
    _isTimerRunning.value = false;
  }
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
  
}