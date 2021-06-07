import 'package:flutter/cupertino.dart';

import 'dht_model.dart';
import 'light_model.dart';

class Pi {
  String piId;
  String name;
  DEVICE_STATUS deviceStatus;
  DEVICE_TYPE deviceType;
  List<Dht> dhtList;
  List<Light> lightList;
  String positionX;
  String positionY;
  ACTIVATE activate;

  Pi({
    this.piId,
    this.name,
    this.deviceStatus,
    this.deviceType,
    this.dhtList,
    this.lightList,
    this.positionX,
    this.positionY,
    this.activate,
  });

  factory Pi.fromJson(Map<String, dynamic> json) {
    var list =
        List<Dht>.from((json['dhtList'] as List).map((e) => Dht.fromJson(e)));
    return Pi(
        piId: json['piId'].toString(),
        name: json['name'].toString(),
        deviceStatus: json['status'] as int == 1
            ? DEVICE_STATUS.ACTIVE
            : DEVICE_STATUS.INACTIVE,
        dhtList: list,
        lightList: [],
        positionX: json['positionX'],
        positionY: json['positionY'],
        activate: json['activated'] as int == 1
            ? ACTIVATE.ACTIVE
            : ACTIVATE.INACTIVATE);
  }

  // @override
  // String toString() {
  //   return 'DHT model => ' +
  //       'piId: ' +
  //       this.piId.toString() +
  //       '\nname: ' +
  //       this.name +
  //       '\deviceStatus: ' +
  //       this.deviceStatus.toString() +
  //       '\ndeviceType: ' +
  //       this.deviceType.toString() +
  //       '\npositionX: ' +
  //       this.positionX +
  //       '\npositionY: ' +
  //       this.positionY +
  //       '\n [ DHT list : \n[ ' +
  //       dhtList.toString() +
  //       ' ]' +
  //       '\n [ Light list : \n[ ' +
  //       lightList.toString() +
  //       '\n';
  // }

  List<Dht> get dhtItem {
    return dhtList;
  }

  List<Light> get lightItem {
    return lightList;
  }
}

enum ACTIVATE { ACTIVE, INACTIVATE }
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
