import 'package:flutter/material.dart';
import 'package:rocket_finances/app/data/enum/delete_recurring_enum.dart';
import 'package:rocket_finances/app/ui/shared/widgets/handler_widget.dart';

class BillRecurringBottomWidget extends StatelessWidget {
  final Function(DeleteRecurringEnum type)? onDelete;
  const BillRecurringBottomWidget({super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              0, 20, 0, 20 + MediaQuery.paddingOf(context).bottom),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [HandlerWidget()],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Text(
                  'Essa conta se repete todos os meses, como quer excluí-la?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_month),
                trailing: Icon(Icons.chevron_right),
                title: Text('Apenas este mês'),
                onTap: () {
                  Navigator.pop(context);
                  if (onDelete != null) onDelete!(DeleteRecurringEnum.oneMonth);
                },
              ),
              ListTile(
                iconColor: Colors.red,
                textColor: Colors.red,
                leading: Icon(Icons.calendar_today_outlined),
                trailing: Icon(Icons.chevron_right),
                title: Text('Definitivamente'),
                onTap: () {
                  Navigator.pop(context);
                  if (onDelete != null) onDelete!(DeleteRecurringEnum.all);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
