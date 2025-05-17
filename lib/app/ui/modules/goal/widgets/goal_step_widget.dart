import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';

class GoalStepWidget extends StatefulWidget {
  final Function(String goal, int months) onNext;
  const GoalStepWidget({super.key, required this.onNext});

  @override
  State<GoalStepWidget> createState() => _GoalStepWidgetState();
}

class _GoalStepWidgetState extends State<GoalStepWidget> with ValidatorsMixin {
  final formKey = GlobalKey<FormState>();

  final goalCtrl = TextEditingController()
    ..text =
        "Quero acumular dinheiro por meio de investimentos sábios e alcançar meu primeiro milhão";
  final monthsCtrl = TextEditingController()..text = "24";

  @override
  void dispose() {
    goalCtrl.dispose();
    monthsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradient = LinearGradient(
      colors: [
        const Color.fromARGB(255, 112, 36, 243),
        const Color.fromARGB(255, 148, 94, 240),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
            18, 20, 18, 20 + MediaQuery.paddingOf(context).bottom),
        child: Container(
          decoration: BoxDecoration(
              gradient: gradient, borderRadius: BorderRadius.circular(30)),
          height: 45,
          child: ElevatedButton.icon(
            onPressed: _onNext,
            label: Text('Próximo'),
            iconAlignment: IconAlignment.end,
            icon: Icon(Icons.arrow_forward),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.white,
                iconColor: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Qual seu objetivo financeiro?',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: goalCtrl,
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration:
                      InputDecoration(hintText: 'Descreva seu objetivo'),
                  validator: isNotEmpty,
                  textInputAction: TextInputAction.next,
                  maxLength: 150,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Quanto tempo em meses você pensa em levar para alcança-lo?',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: monthsCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'ex: 1, 2, 3...',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'meses',
                            style: TextStyle(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onFieldSubmitted: (_) => _onNext(),
                  validator: (value) => combine([
                    () => isNotEmpty(value),
                    () => isMoreThanZero(value),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onNext() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    widget.onNext(goalCtrl.text, int.parse(monthsCtrl.text));
  }
}
