import 'package:flutter/material.dart';

class NotificationListWidget extends StatelessWidget {
  final Widget title, subtitle, lead, trailing;

  const NotificationListWidget({
    Key key,
    this.title,
    this.subtitle,
    this.lead,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: lead,
      title: title,
      subtitle: subtitle,
      trailing: FittedBox(child: trailing),
    );
  }
}
