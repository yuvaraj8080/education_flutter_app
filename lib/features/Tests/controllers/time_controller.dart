
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';


class TimerController extends GetxController {
  VoidCallback onFinish;
  TimerController({required this.onFinish});
  final RxInt _minutes = 0.obs;
  final RxInt _seconds = 0.obs;
  final RxBool _isTimerRunning = false.obs;
  Timer? _timer;
   int _startTime = 0;
  String get timerDisplay => "${_minutes.value.toString().padLeft(2, '0')}:${_seconds.value.toString().padLeft(2, '0')}";

  void startTimer(int duration) {
     _startTime = DateTime.now().millisecondsSinceEpoch;
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    _minutes.value = minutes;
    _seconds.value = seconds;
    _isTimerRunning.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (_seconds.value < 1) {
        _seconds.value = 59;
        _minutes.value--;
      } else {
        _seconds.value--;
      }
      if (_minutes.value < 0 || (_minutes.value == 0 && _seconds.value == 0)) {
        t.cancel();
        _isTimerRunning.value = false;
        onFinish();
      }
      update();
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

  String getElapsedTime() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int elapsedTime = currentTime - _startTime; // Calculate the elapsed time in milliseconds
    int elapsedSeconds = elapsedTime ~/ 1000; // Convert milliseconds to seconds
    int minutes = elapsedSeconds ~/ 60; // Calculate minutes
    int seconds = elapsedSeconds % 60; // Calculate seconds
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}"; // Return the elapsed time in minutes and seconds format
  }

  void resetTimer() {
    _minutes.value = 0;
    _seconds.value = 0;
    _isTimerRunning.value = false;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}