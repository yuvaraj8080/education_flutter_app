class TestResult {
  int totalSkippedQuestions = 0;
  int totalWrongAnswers = 0;
  int totalCorrectAnswers = 0;
  int totalQuestions = 0;
  List<String> mcqAnswers=[]; 
  List<String> numericalAnswers=[];
   TestResult({required this.totalCorrectAnswers,required this.totalWrongAnswers,required this.totalQuestions});
}