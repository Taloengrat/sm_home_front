import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sm_home_nbcha/models/notification_model.dart';

class Notifications with ChangeNotifier {
  List<NotificationModel> _item = [];

  List<NotificationModel> get item {
    return [..._item];
  }

  sendNotification(NotificationModel notification) {
    _item.add(notification);
    notifyListeners();
  }
}
