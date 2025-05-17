class LoadingAnalysisArgs {
  final List<String> skills;
  final String goalDescription;
  final double requiredValue;
  final double savedValue;
  final int due;

  LoadingAnalysisArgs(
      {required this.skills,
      required this.goalDescription,
      required this.requiredValue,
      required this.savedValue,
      required this.due});
}
