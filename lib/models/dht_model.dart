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
      piId: json['piId'].toString(),
      dhtId: json['dhtId'].toString(),
      name: json['name'].toString(),
      status: json['status'] as int == 1
          ? DEVICE_STATUS.ACTIVE
          : DEVICE_STATUS.INACTIVE,
      isOnline: json['isOnline'] as int == 1
          ? DEVICE_ONLINE.ACTIVE
          : DEVICE_ONLINE.INACTIVE,
      temperature: json['temperature'].toString(),
      moisture: json['moisture'].toString(),
      positionX: json['positionX'].toString(),
      positionY: json['positionY'].toString(),
    );
  }
  // @override
  // String toString() {
  //   return 'DHT model => ' +
  //       'dhtId: ' +
  //       this.dhtId +
  //       '\npiId: ' +
  //       this.piId +
  //       '\nname: ' +
  //       this.name +
  //       '\nstatus: ' +
  //       this.status.toString() +
  //       '\isOnline: ' +
  //       this.isOnline.toString() +
  //       '\ntemperature: ' +
  //       this.temperature +
  //       '\nmoisture: ' +
  //       this.moisture +
  //       '\npositionX: ' +
  //       this.positionX +
  //       '\npositionY: ' +
  //       this.positionY;
  // }
}

enum DEVICE_ONLINE { ACTIVE, INACTIVE }
