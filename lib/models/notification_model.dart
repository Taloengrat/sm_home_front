import 'package:flutter/material.dart';

class NotificationModel {
  String title;
  String subTitle;
  String date;
  NOTIFICATION_TYPE notificationType;

  NotificationModel({
    this.title,
    this.subTitle,
    this.date,
    this.notificationType,
  });
}

enum NOTIFICATION_TYPE { WARNNING, INFO, OTP }
