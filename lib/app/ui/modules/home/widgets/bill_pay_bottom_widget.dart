import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/bill_tile_widget.dart';
import 'package:rocket_finances/app/ui/shared/widgets/handler_widget.dart';

enum PaymentOptionsEnum {
  partial,
  complete;

  bool get isPartial => this == PaymentOptionsEnum.partial;
  bool get isComplete => this == PaymentOptionsEnum.complete;
}

class BillPayBottomWidget extends StatefulWidget {
  final BillModel bill;
  const BillPayBottomWidget({super.key, required this.bill});

  @override
  State<BillPayBottomWidget> createState() => _BillPayBottomWidgetState();
}

class _BillPayBottomWidgetState extends State<BillPayBottomWidget>
    with ValidatorsMixin {
  PaymentOptionsEnum selectedOption = PaymentOptionsEnum.complete;

  final formKey = GlobalKey<FormState>();

  final valueCtrl = TextEditingController();

  @override
  void dispose() {
    valueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return BlocListener<BillsCubit, BillsState>(
          listener: (context, state) {
            if (state.status.isPaid) {
              Navigator.of(context).pop();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  18,
                  20,
                  18,
                  20 +
                      MediaQuery.paddingOf(context).bottom +
                      MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [HandlerWidget()],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pagar conta',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BillTileWidget(
                    bill: widget.bill,
                    useVariant: true,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Opções de pagamento',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    splashColor: Colors.transparent,
                    onTap: () => _toggleOption(PaymentOptionsEnum.complete),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: selectedOption.isComplete
                              ? colorScheme.primaryContainer
                              : colorScheme.surface),
                    ),
                    tileColor: selectedOption.isComplete
                        ? colorScheme.primaryContainer.withValues(alpha: .4)
                        : containerColor,
                    leading: Radio<PaymentOptionsEnum>(
                      value: PaymentOptionsEnum.complete,
                      groupValue: selectedOption,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) => _toggleOption(value!),
                    ),
                    title: Text('Pagar valor completo'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: selectedOption.isPartial
                          ? colorScheme.primaryContainer.withValues(alpha: .4)
                          : containerColor,
                      border: Border.all(
                          color: selectedOption.isPartial
                              ? colorScheme.primaryContainer
                              : colorScheme.surface),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          splashColor: Colors.transparent,
                          onTap: () =>
                              _toggleOption(PaymentOptionsEnum.partial),
                          leading: Radio<PaymentOptionsEnum>(
                            value: PaymentOptionsEnum.partial,
                            groupValue: selectedOption,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) => _toggleOption(value!),
                          ),
                          title: Text('Pagar valor parcial'),
                        ),
                        Visibility(
                          visible: selectedOption.isPartial,
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18, 10, 18, 20),
                              child: TextFormField(
                                controller: valueCtrl,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Digite o valor',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => combine([
                                  () => isNotEmpty(value),
                                  () => isMoreThanZeroMoney(value),
                                  () => isLessThanOrEqualTo(
                                      value, widget.bill.remainingValue),
                                ]),
                                inputFormatters: [
                                  AppHelpers.currencyFormatter()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<BillsCubit, BillsState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.status.isLoading ? null : _pay,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            colorScheme.primaryContainer.withValues(alpha: .7),
                          ),
                        ),
                        child: state.status.isLoading
                            ? Transform.scale(
                                scale: .4, child: CircularProgressIndicator())
                            : Text('Pagar!'),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleOption(PaymentOptionsEnum option) {
    setState(() {
      selectedOption = option;
    });
  }

  void _pay() {
    if (!(formKey.currentState?.validate() ?? false) &&
        selectedOption.isPartial) {
      return;
    }

    var value = AppHelpers.revertCurrency(valueCtrl.text);

    BlocProvider.of<BillsCubit>(context).payBill(widget.bill.id,
        selectedOption.isComplete ? widget.bill.remainingValue : value * 1.0);
  }
}
