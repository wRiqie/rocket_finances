import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/bills_widget.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/receipts_widget.dart';

enum HomeTabEnum {
  bills,
  receipts;

  bool get isBills => this == HomeTabEnum.bills;
  bool get isReceipts => this == HomeTabEnum.receipts;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTabEnum selectedTab = HomeTabEnum.bills;

  @override
  Widget build(BuildContext context) {
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
                BlocBuilder<BillsCubit, BillsState>(
                  builder: (context, state) {
                    return Container(
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
                                state.bills.isNotEmpty
                                    ? AppHelpers.formatCurrency(
                                        state.bills.totalPaid)
                                    : '-',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: state.bills.isNotEmpty
                                ? state.bills.totalPaidProportion
                                : 0.0,
                            minHeight: 20,
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                            backgroundColor: colorScheme.surface,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${state.bills.isNotEmpty ? state.bills.paidPercentage : '-'}%'),
                              Text(
                                  'Falta ${AppHelpers.formatCurrency(state.bills.isNotEmpty ? state.bills.remainingValue : 0)}'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 26),
                Text(
                  'Finanças',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colorScheme.surfaceContainer,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        children: [
                          _buildTabButton('Contas', HomeTabEnum.bills),
                          _buildTabButton('Recebimentos', HomeTabEnum.receipts),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                selectedTab.isBills ? BillsWidget() : ReceiptsWidget(),
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

  Widget _buildTabButton(String text, HomeTabEnum tab) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () => _toggleTab(tab),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.surfaceBright : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? colorScheme.surface : Colors.transparent,
            ),
          ),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }

  void _toggleTab(HomeTabEnum tab) {
    setState(() {
      selectedTab = tab;
    });
  }
}
