import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';
import 'package:rocket_finances/app/core/values/images.dart';

class SkillsStepWidget extends StatefulWidget {
  final Function(List<String> skills) onConfirm;
  const SkillsStepWidget({super.key, required this.onConfirm});

  @override
  State<SkillsStepWidget> createState() => _SkillsStepWidgetState();
}

class _SkillsStepWidgetState extends State<SkillsStepWidget>
    with ValidatorsMixin {
  final formKey = GlobalKey<FormState>();

  final skillOneCtrl = TextEditingController()..text = "Programação";
  final skillTwoCtrl = TextEditingController()..text = "Visão de empreendedor";
  final skillThreeCtrl = TextEditingController()..text = "Marketing";

  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 112, 36, 243),
      const Color.fromARGB(255, 148, 94, 240),
    ],
  );

  @override
  void dispose() {
    skillOneCtrl.dispose();
    skillTwoCtrl.dispose();
    skillThreeCtrl.dispose();
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
              label: Text('Analisar com IA'),
              icon: SvgPicture.asset(
                Images.sparkles,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
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
                  'Precisamos saber até 3 habilidades profissionais suas:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Habilidade #1',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: skillOneCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          hintText: 'ex: Programação, Design, Copywriting...'),
                      validator: isNotEmpty,
                      textInputAction: TextInputAction.next,
                      maxLength: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Habilidade #2',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: skillTwoCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          hintText: 'ex: Contabilidade, Administração...'),
                      textInputAction: TextInputAction.next,
                      maxLength: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Habilidade #3',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: skillThreeCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          hintText: 'ex: Marketing, Linguagens,...'),
                      maxLength: 100,
                      onFieldSubmitted: (value) => _onConfirm(),
                    ),
                  ],
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

    List<String> skills = [];
    for (var text in [
      skillOneCtrl.text,
      skillTwoCtrl.text,
      skillThreeCtrl.text
    ]) {
      if (text.trim().isNotEmpty) {
        skills.add(text);
      }
    }

    widget.onConfirm(skills);
  }
}
