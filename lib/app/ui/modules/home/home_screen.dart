import 'package:flutter/material.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/spend_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;

    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colorScheme.surfaceContainer,
                    ),
                  ),
                  child: Column(
                    spacing: 12,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Já gastou',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'R\$ 8395,10',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SpendBarWidget(size: size, colorScheme: colorScheme),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('84%'),
                          Text('Falta R\$ 1432,23'),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 26),
                Text(
                  'Finanças',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'A pagar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface.withValues(alpha: .45)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Ver tudo'),
                    ),
                  ],
                ),
                Column(
                  spacing: 12,
                  children: [
                    BillTileWidget(),
                    BillTileWidget(),
                    BillTileWidget(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'A receber',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface.withValues(alpha: .45)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Ver tudo'),
                    ),
                  ],
                ),
                Column(
                  spacing: 12,
                  children: [
                    BillTileWidget(),
                    BillTileWidget(),
                    BillTileWidget(),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BillTileWidget extends StatelessWidget {
  const BillTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return ListTile(
      tileColor: containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.surfaceContainer),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      leading: CircleAvatar(
        child: Icon(Icons.home_outlined),
      ),
      title: Text('Água'),
      subtitle: Text('Contas da casa'),
      trailing: Column(
        // spacing: ,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'R\$ 79,90',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            'Pagar',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.primaryFixedDim,
            ),
          ),
        ],
      ),
    );
  }
}
