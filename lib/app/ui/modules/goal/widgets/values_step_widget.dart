import 'package:flutter/material.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';

class ValuesStepWidget extends StatefulWidget {
  final Function(double requiredValue, double savedValue) onConfirm;
  const ValuesStepWidget({super.key, required this.onConfirm});

  @override
  State<ValuesStepWidget> createState() => _ValuesStepWidgetState();
}

class _ValuesStepWidgetState extends State<ValuesStepWidget>
    with ValidatorsMixin {
  final formKey = GlobalKey<FormState>();

  final requiredValueCtrl = TextEditingController()
    ..text = AppHelpers.formatCurrency(1000000);
  final savedValueCtrl = TextEditingController()
    ..text = AppHelpers.formatCurrency(930);

  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 112, 36, 243),
      const Color.fromARGB(255, 148, 94, 240),
    ],
  );

  @override
  void dispose() {
    requiredValueCtrl.dispose();
    savedValueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
            18, 20, 18, 20 + MediaQuery.paddingOf(context).bottom),
        child: Container(
          decoration: BoxDecoration(
              gradient: gradient, borderRadius: BorderRadius.circular(30)),
          height: 45,
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient, borderRadius: BorderRadius.circular(30)),
            height: 45,
            child: ElevatedButton.icon(
              onPressed: _onConfirm,
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
                  'Quanto você precisa de dinheiro para o objetivo?',
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
                  controller: requiredValueCtrl,
                  decoration: InputDecoration(hintText: 'ex: 30.000,00'),
                  keyboardType: TextInputType.number,
                  validator: (value) => combine([
                    () => isNotEmpty(value),
                    () => isMoreThanZeroMoney(value),
                  ]),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [AppHelpers.currencyFormatter()],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Já tem alguma quantia guardada(opcional)?',
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
                  controller: savedValueCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'ex: 2500,00'),
                  inputFormatters: [AppHelpers.currencyFormatter()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onConfirm() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final requiredValue =
        AppHelpers.revertCurrency(requiredValueCtrl.text) * 1.0;
    final savedValue = AppHelpers.revertCurrency(savedValueCtrl.text) * 1.0;

    widget.onConfirm(requiredValue, savedValue);
  }
}
