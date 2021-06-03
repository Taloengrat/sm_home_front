import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sm_home_nbcha/models/pi_model.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'package:sm_home_nbcha/providers/users.dart';
import 'package:sm_home_nbcha/screens/main/widgets/equipment_card_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class DeviceField extends StatefulWidget {
  const DeviceField({
    Key key,
    @required this.size,
    @required bool isLoading,
    @required this.device,
    @required this.id,
    @required this.token,
  })  : _isLoading = isLoading,
        super(key: key);

  final Size size;
  final bool _isLoading;
  final String id;
  final String token;
  final List<Pi> device;

  @override
  _DeviceFieldState createState() => _DeviceFieldState();
}

class _DeviceFieldState extends State<DeviceField> {
  bool isOpen = true;
  final _formCreatePiKey = GlobalKey<FormState>();
  final piNameController = TextEditingController();
  final statusController = TextEditingController();
  var _isCreateLoading = false;
  String tokenId;

  @override
  Widget build(BuildContext context) {
    print('ID Device => ' + widget.id);
    print('TOKEN => ' + widget.token);
    return Container(
      width: widget.size.width * 0.6,
      height: widget.size.height * 0.7,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white.withOpacity(0.8),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0XFFEFF3F6),
                      borderRadius: BorderRadius.circular(48.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(6, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.1),
                            offset: Offset(-6, -2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0)
                      ],
                    ),
                    child: Tooltip(
                      message: 'New device',
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _showDialogCreateDevice(),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Scrollbar(
                  radius: Radius.circular(15),
                  child: widget._isLoading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Text('Loding'),
                              ),
                            ],
                          ),
                        )
                      : widget.device.isNotEmpty
                          ? ListView(children: [
                              ...widget.device.map((element) {
                                print(element);
                                return DeviceCardList(
                                  title: element.name,
                                  status: element.deviceStatus,
                                  subTitle: Text(''),
                                  icon: SvgPicture.asset('images/circuit.svg'),
                                  // dhtList: element.dhtList.toList(),
                                  // lightList: element.lightList.toList(),
                                );
                              })
                            ]

                              // },
                              )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No have any device'),
                                  Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Provider.of<Devices>(context)
                                            .fetchData(widget.id, widget.token);
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialogCreateDevice() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Create Device',
              ),
            ),
            content: Form(
              key: _formCreatePiKey,
              child: Container(
                height: 140,
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0XFFEFF3F6),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              offset: Offset(6, 2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0),
                          BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              offset: Offset(-6, -2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0)
                        ],
                      ),
                      child: TextFormField(
                        controller: piNameController,
                        decoration: getInputDecoration('Device name', null),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter Machine Name';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0XFFEFF3F6),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              offset: Offset(6, 2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0),
                          BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              offset: Offset(-6, -2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0)
                        ],
                      ),
                      child: TextFormField(
                        controller: statusController,
                        decoration: getInputDecoration('Status', null),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter status';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('submit'),
                onPressed: () {
                  if (_formCreatePiKey.currentState.validate()) {
                    submitData();
                  }
                },
              )
            ],
          );
        });
  }

  InputDecoration getInputDecoration(String labelText, Widget suffixIcon) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      border: InputBorder.none,
      hintText: labelText,
    );
  }

  void submitData() {
    print('SUBMITTED');

    setState(() {
      _isCreateLoading = true;
    });

    createEquipment('1', piNameController.text, 0).then((value) {
      Map response = jsonDecode(value.body);
      bool resBool = response['responseMessage'];

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(resBool ? 'Success' : 'Fail')),
              content: Container(
                height: 70,
                width: 60,
                child: Icon(
                  resBool ? Icons.check_rounded : Icons.clear_rounded,
                  color: resBool ? Colors.greenAccent : Colors.redAccent,
                  size: 40,
                ),
              ),
              actions: [
                Center(
                  child: FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      if (resBool) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            );
          });
    });
  }

  Future<http.Response> createEquipment(
      String userId, String piName, int status) async {
    return http.post(
      Uri.parse('http://3.142.219.106:3030/device/pi/add-pi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'piName': piName,
        'status': status,
      }),
    );
  }
}
