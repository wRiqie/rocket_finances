import 'package:flutter/material.dart';

class LoggedAppBarWidget extends StatelessWidget {
  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapSettings;
  const LoggedAppBarWidget(
      {super.key, this.onTapNotifications, this.onTapSettings});

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
                            child: Text('H'),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Olá Henrique',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  spacing: 12,
                                  children: [
                                    Text('R\$ 185,95'),
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
