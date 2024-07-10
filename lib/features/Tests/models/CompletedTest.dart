class CompletedTest {
  String weekNumber;
  String topic;
  int totalSkippedQuestions = 0;
  int totalWrongAnswers = 0;
  int totalCorrectAnswers = 0;
  int totalQuestions = 0;
  String Timetaken;

  CompletedTest({required this.weekNumber, required this.topic, required this.totalSkippedQuestions,required this.totalWrongAnswers,required this.totalCorrectAnswers,required this.totalQuestions,required this.Timetaken});

  factory CompletedTest.fromMap(Map<String, dynamic> map) {
    return CompletedTest(
      weekNumber: map['weekNumber'],
      topic: map['topic'],
      totalCorrectAnswers:  map['totalCorrectAnswers'],
      totalWrongAnswers: map['totalWrongAnswers'],
      totalSkippedQuestions: map['totalSkippedQuestions'],
      totalQuestions: map['totalQuestions'],
      Timetaken: map['Timetaken']
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'weekNumber': weekNumber,
      'topic': topic,
      'totalCorrectAnswers':  totalCorrectAnswers,
      'totalWrongAnswers': totalWrongAnswers,
      'totalSkippedQuestions':totalSkippedQuestions,
      'totalQuestions': totalQuestions,
      'Timetaken':Timetaken
    };
  }
}