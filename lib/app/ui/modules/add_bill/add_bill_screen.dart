import 'package:flutter/material.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({super.key});

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  final isRecurring = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar gasto'),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
            18, 20, 18, 20 + MediaQuery.paddingOf(context).bottom),
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Salvar'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
          child: Column(
            spacing: 20,
            children: [
              Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nome',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Digite o nome',
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Valor',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Digite o valor',
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Categoria',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category_outlined),
                      hintText: 'Selecione a categoria',
                      suffixIcon: Icon(Icons.chevron_right),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'É recorrente?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Marque se tem o gasto todos os meses',
                        style: TextStyle(
                          color: colorScheme.onSurface.withValues(alpha: .6),
                        ),
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: isRecurring,
                    builder: (context, value, child) {
                      return Switch(
                        value: value,
                        onChanged: (value) {
                          isRecurring.value = !isRecurring.value;
                        },
                        thumbIcon: WidgetStateProperty.resolveWith(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Icon(Icons.check);
                            } else {
                              return Icon(Icons.close);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
