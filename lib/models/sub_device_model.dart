class SubDevice {
  String id;
  String status;
  String isOnline;
  String temperature;
  String moisture;

  SubDevice({
    this.id,
    this.status,
    this.isOnline,
    this.temperature,
    this.moisture,
  });

  factory SubDevice.fromJson(Map<String, dynamic> json) {
    return SubDevice(
      id: json['responseMessage']['id'].toString(),
      status: json['responseMessage']['status'].toString(),
      isOnline: json['responseMessage']['isOnline'].toString(),
      temperature: json['responseMessage']['temperature'].toString(),
      moisture: json['responseMessage']['moisture'].toString(),
    );
  }
}
