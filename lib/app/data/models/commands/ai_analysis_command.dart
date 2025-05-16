class AiAnalysisCommand {
  final List<String> skills;
  final String goal;
  final String requiredValue;
  final String savedValue;
  final String due;

  AiAnalysisCommand(
      {required this.skills,
      required this.goal,
      required this.requiredValue,
      required this.savedValue,
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
