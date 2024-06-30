import 'package:flutter_job_app/features/Tests/models/testresult.dart';

class TestResultSingleton {
  // int _totalQuestions = 0;
  // int _totalCorrectAnswers = 0;
  // int _totalWrongAnswers = 0;

  static TestResultSingleton? _instance;
  TestResult _testResult=TestResult(
    totalCorrectAnswers: 0,
    totalWrongAnswers: 0,
    totalQuestions: 0,
  );

  TestResultSingleton._internal() {}

  static TestResultSingleton getInstance() {
    if (_instance == null) {
      _instance = TestResultSingleton._internal();
    }
    return _instance!;
  }

    TestResult get testResult => _testResult; 

  void updateTestResult(int correctAnswers, int wrongAnswers, int questions) {
    _testResult = TestResult(
      totalCorrectAnswers: correctAnswers,
      totalWrongAnswers: wrongAnswers,
      totalQuestions: questions,
    );
  }
  void reset() {
    _testResult.totalQuestions = 0;
    _testResult.totalCorrectAnswers = 0;
    _testResult.totalWrongAnswers = 0;
  }
}