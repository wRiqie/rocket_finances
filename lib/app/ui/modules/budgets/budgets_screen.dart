import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/budgets/budgets_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/budgets/budgets_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/models/args/add_budget_args.dart';
import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:rocket_finances/app/ui/shared/dialogs/decision_dialog.dart';
import 'package:rocket_finances/app/ui/shared/widgets/options_bottom_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class BudgetsScreen extends StatefulWidget {
  const BudgetsScreen({super.key});

  @override
  State<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  final sessionHelper = GetIt.I<SessionHelper>();

  @override
  void initState() {
    super.initState();

    _loadBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetsCubit, BudgetsState>(
      listener: (context, state) {
        if (state.status.isError) {
          ErrorSnackbar(context, message: state.error?.message);
        } else if (state.status.isDeleted) {
          SuccessSnackbar(context, message: 'Deletado com sucesso');
          _loadBudgets();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carteira'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addBudget,
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<BudgetsCubit, BudgetsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Erro ao carregar carteira'),
                    TextButton.icon(
                      onPressed: _loadBudgets,
                      label: Text('Recarregar'),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            }

            if (state.budgets.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ainda sem orçamentos'),
                    TextButton.icon(
                      onPressed: _addBudget,
                      label: Text('Adicionar'),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                child: Column(
                  children: state.budgets
                      .map(
                        (e) => ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.wallet),
                          ),
                          title: Text(e.name),
                          subtitle: Text(
                            AppHelpers.formatCurrency(e.value),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => OptionsBottomWidget(
                                onEdit: () => _updateBudget(e),
                                onDelete: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DecisionDialog(
                                      title: 'Deletar orçamento',
                                      content:
                                          'Tem certeza que deseja deletar o orçamento?',
                                      onConfirm: () => _deleteBudget(e.id),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadBudgets() {
    final userId = sessionHelper.currentUser?.id;

    BlocProvider.of<BudgetsCubit>(context).getAllBudgetsByUserId(userId ?? '');
  }

  void _deleteBudget(int id) {
    BlocProvider.of<BudgetsCubit>(context).deleteBudgetById(id);
  }

  void _addBudget() async {
    final result = await Navigator.pushNamed(context, AppRoutes.addBudget);

    if (result == true) {
      _loadBudgets();
    }
  }

  void _updateBudget(BudgetModel budget) async {
    final result = await Navigator.pushNamed(context, AppRoutes.addBudget,
        arguments: AddBudgetArgs(budget));

    if (result == true) {
      _loadBudgets();
    }
  }
}
