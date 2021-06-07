import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:sm_home_nbcha/models/pi_model.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sm_home_nbcha/models/user_model.dart';

class Devices with ChangeNotifier {
  List<Pi> _items = [];
  User _item;

  List<Pi> get item {
    return [..._items];
  }

  final Storage localStorage = window.localStorage;

  Future save(User user) async {
    localStorage['user_id_and_token'] = user.id + ':' + user.token;

    print('save user : ' + user.toString());
  }

  clearStorage() async {
    localStorage.remove('user_id_and_token');
  }

  Future<String> getIdandToken() async => localStorage['user_id_and_token'];

  Future<void> fetchData() async {
    var string = await getIdandToken();

    final url =
        'https://smarthome-backend-chban.com/device/pi/get-pi-by-user-id/' +
            string.toString();

    // print('STRING ' + string);
    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + string.split(':').elementAt(1),
      });

      Map extractedData = jsonDecode(response.body);
      // print('res body => ' + response.body);

      if (extractedData == null) {
        return;
      }

      final List<Pi> equipment = (extractedData['responseMessage'] as List)
          .map((element) => Pi.fromJson(element))
          .toList();

      _items = equipment;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<http.Response> createEquipment(String piName, int status) async {
    var userIdAndToken = await getIdandToken();

    return http.post(
      Uri.parse('https://smarthome-backend-chban.com/device/pi/add-pi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            'Bearer ' + userIdAndToken.split(':').elementAt(1),
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userIdAndToken.split(':').elementAt(0),
        'piName': piName,
        'status': status,
      }),
    );
  }

  Future<http.Response> confirmOtp(String otp, String piId) async {
    var userIdAndToken = await getIdandToken();

    return http.post(
      Uri.parse('https://smarthome-backend-chban.com/device/pi/confirm-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            'Bearer ' + userIdAndToken.split(':').elementAt(1),
      },
      body: jsonEncode(<String, dynamic>{
        'piId': piId,
        'otp': otp,
      }),
    );
  }
}
