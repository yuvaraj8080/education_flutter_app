class TestScore {
  int mcqScore;
  int numericalScore;

  TestScore({required this.mcqScore, required this.numericalScore});

  int get overallScore => mcqScore + numericalScore;
}