import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_home_nbcha/providers/notifications.dart';

import 'notification_list_widget.dart';

class NotificationBadgeWidget extends StatefulWidget {
  const NotificationBadgeWidget({
    Key key,
  }) : super(key: key);

  @override
  _NotificationBadgeWidgetState createState() =>
      _NotificationBadgeWidgetState();
}

class _NotificationBadgeWidgetState extends State<NotificationBadgeWidget> {
  @override
  Widget build(BuildContext context) {
    final notificationList = Provider.of<Notifications>(context).item;

    return PopupMenuButton(
      tooltip: 'Notification',
      onSelected: notificationAction,
      offset: Offset(0, 55),
      itemBuilder: (ctx) {
        return notificationList.map((notiInfo) {
          return PopupMenuItem(
            value: notiInfo.title,
            child: NotificationListWidget(
              lead: Icon(Icons.notifications_active),
              title: Text(notiInfo.title),
              subtitle: Text(notiInfo.subTitle),
              trailing: Text(notiInfo.subTitle),
            ),
          );
        }).toList();
      },
      child: Badge(
        showBadge: true,
        position: BadgePosition.topEnd(top: 1, end: 1),
        animationDuration: Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          notificationList.length.toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          tooltip: 'Notification',
        ),
      ),
    );
  }

  void notificationAction(String choise) {
    // switch (choise) {
    //   case 'Sign Out':
    //     // Navigator.of(context).pushReplacementNamed(BeginScreen.route);
    //     break;
    //   case 'Setting':
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => ProfileSettingPage(
    //           fullName: 'Admin',
    //           phoneNumber: '0828397987',
    //         ),
    //       ),
    //     );
    //     break;
    //   case 'Profile':
    //     break;
    //   default:
    // }
  }
}
