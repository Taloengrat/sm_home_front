import 'package:flutter/cupertino.dart';

import 'dht_model.dart';
import 'light_model.dart';

class Pi {
  int piId;
  String name;
  DEVICE_STATUS deviceStatus;
  DEVICE_TYPE deviceType;
  List<Dht> dhtList;
  List<Light> lightList;
  String positionX;
  String positionY;

  Pi({
    this.piId,
    this.name,
    this.deviceStatus,
    this.deviceType,
    this.dhtList,
    this.lightList,
    this.positionX,
    this.positionY,
  });

  factory Pi.fromJson(Map<String, dynamic> json) {
    return Pi(
      piId: json['piId'] as int,
      name: json['name'].toString(),
      deviceStatus: json['status'] as int == 1
          ? DEVICE_STATUS.ACTIVE
          : DEVICE_STATUS.INACTIVE,
      dhtList: (json['dhtList'] as List).map((e) => Dht.fromJson(e)),
      // lightList: json['lightList'],
      positionX: json['positionX'],
      positionY: json['positionY'],
    );
  }

  List<Dht> get dhtItem {
    return dhtList;
  }

  List<Light> get lightItem {
    return lightList;
  }
}

enum DEVICE_TYPE {
  TOOL,
  APPLIANCE,
  DEVICE,
  BOOK,
  TOY,
  VIDEO,
  PHOTO,
  SENSOR,
}

enum DEVICE_STATUS { ACTIVE, INACTIVE }
