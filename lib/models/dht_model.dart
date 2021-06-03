import 'pi_model.dart';

class Dht {
  String piId;
  String dhtId;
  String name;
  DEVICE_STATUS status;
  DEVICE_ONLINE isOnline;
  String temperature;
  String moisture;
  String positionX;
  String positionY;

  Dht({
    this.piId,
    this.dhtId,
    this.name,
    this.status,
    this.isOnline,
    this.temperature,
    this.moisture,
    this.positionX,
    this.positionY,
  });

  factory Dht.fromJson(Map<String, dynamic> json) {
    return Dht(
      piId: json['piId'] as String,
      dhtId: json['dhtId'] as String,
      name: json['name'],
      status: json['status'] as int == 1
          ? DEVICE_STATUS.ACTIVE
          : DEVICE_STATUS.INACTIVE,
      isOnline: json['isOnline'] as int == 1
          ? DEVICE_ONLINE.ACTIVE
          : DEVICE_ONLINE.INACTIVE,
      temperature: json['temperature'],
      moisture: json['moisture'],
      positionX: json['positionX'],
      positionY: json['positionY'],
    );
  }
}

enum DEVICE_ONLINE { ACTIVE, INACTIVE }
