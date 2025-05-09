import 'package:flutter/material.dart';
import 'package:rocket_finances/app/ui/shared/widgets/handler_widget.dart';

class BillOptionsBottomWidget extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const BillOptionsBottomWidget({super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
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
              ListTile(
                leading: Icon(Icons.edit_outlined),
                trailing: Icon(Icons.chevron_right),
                title: Text('Editar'),
                onTap: () {
                  Navigator.pop(context);
                  if (onEdit != null) onEdit!();
                },
              ),
              ListTile(
                iconColor: Colors.red,
                textColor: Colors.red,
                leading: Icon(Icons.delete_outline),
                trailing: Icon(Icons.chevron_right),
                title: Text('Excluir'),
                onTap: () {
                  Navigator.pop(context);
                  if (onDelete != null) onDelete!();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
