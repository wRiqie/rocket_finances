import 'package:flutter/material.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/data/models/user_model.dart';

class LoggedAppBarWidget extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapSettings;
  const LoggedAppBarWidget(
      {super.key, this.user, this.onTapNotifications, this.onTapSettings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(),
          padding: EdgeInsets.fromLTRB(
              18, MediaQuery.viewPaddingOf(context).top, 18, 4),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            child: Text((user?.name ?? 'U')[0]),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Olá ${user?.name ?? '...'}',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  spacing: 12,
                                  children: [
                                    Text(AppHelpers.formatCurrency(
                                        user?.remainingBudget)),
                                    Icon(
                                      Icons.visibility_outlined,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onTapNotifications,
                          icon: Icon(Icons.notifications_outlined),
                        ),
                        IconButton(
                          onPressed: onTapSettings,
                          icon: Icon(Icons.settings_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
