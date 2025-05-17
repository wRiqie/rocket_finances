class AiAnalysisCommand {
  final List<String> skills;
  final String goal;
  final double requiredValue;
  final double? savedValue;
  final int due;

  AiAnalysisCommand(
      {required this.skills,
      required this.goal,
      required this.requiredValue,
      this.savedValue,
      required this.due});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'habilidades': skills,
      'meta': {
        'objetivo': goal,
        'valor_necessario': requiredValue,
        'valor_guardado_atualmente': savedValue,
        'prazo_meses': due,
      },
    };
  }
}
