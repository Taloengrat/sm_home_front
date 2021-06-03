import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sm_home_nbcha/models/dht_model.dart';
import 'package:sm_home_nbcha/models/light_model.dart';
import 'package:sm_home_nbcha/models/pi_model.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Devices with ChangeNotifier {
  List<Pi> _items = [];

  List<Pi> get item {
    return [..._items];
  }

  Future<void> fetchData(String userId, String token) async {
    // print('FETCH');
    final url =
        'https://smarthome-backend-chban.com/device/pi/get-pi-by-user-id/' +
            userId;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
      });

      Map extractedData = jsonDecode(response.body);
      print('res body => ' + response.body);
      if (extractedData == null) {
        return;
      }

      final List<Pi> equipment = (extractedData['responseMessage'] as List)
          .map((element) => Pi.fromJson(element))
          .toList();

      _items = equipment;

      print('NOTIFY');
      print('RESSSSSSSSS ' + equipment[1].dhtList.toString());
      notifyListeners();

      print("LIST => " + _items.toString());
    } catch (error) {
      throw (error);
    }
  }
}
