import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sm_home_nbcha/models/dht_model.dart';
import 'package:sm_home_nbcha/models/light_model.dart';
import 'package:sm_home_nbcha/models/pi_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'list_tile_expand_widget.dart';
import 'package:provider/provider.dart';

class DeviceCardList extends StatefulWidget {
  final Widget icon;
  final DEVICE_STATUS status;
  final String title;
  final Widget subTitle;
  final Function function;
  final List<Dht> dhtList;
  final List<Light> lightList;
  final bool activate;

  const DeviceCardList({
    Key key,
    this.icon,
    this.title,
    this.status,
    this.subTitle,
    this.function,
    this.dhtList,
    this.lightList,
    this.activate,
  }) : super(key: key);

  @override
  _DeviceCardListState createState() => _DeviceCardListState();
}

class _DeviceCardListState extends State<DeviceCardList> {
  bool _isExpand = false;
  bool _isVisiblePass = false;
  SlidableController slidableController;
  final _OtpController = TextEditingController();

  @override
  void initState() {
    // slidableController = SlidableController(
    //   onSlideAnimationChanged: handleSlideAnimationChanged,
    //   onSlideIsOpenChanged: handleSlideIsOpenChanged,
    // );
    super.initState();
  }

// void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
//     setState(() {
//       _rotationAnimation = slideAnimation;
//     });
//   }

//   void handleSlideIsOpenChanged(bool? isOpen) {
//     setState(() {
//       _fabColor = isOpen! ? Colors.green : Colors.blue;
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.activate ? Colors.white : Colors.grey,
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 1 / 5,
        actions: [
          if (!widget.activate)
            IconSlideAction(
              caption: 'OTP',
              iconWidget: SvgPicture.asset('images/otp.svg'),
              color: Colors.amber,
              onTap: () => showDialogConfirmOTP(),
            ),
        ],
        child: ExpansionTile(
          expandedAlignment: Alignment.bottomCenter,
          tilePadding: EdgeInsets.all(5),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpand = !_isExpand;
            });
          },
          childrenPadding: EdgeInsets.all(1),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.icon,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              widget.status == DEVICE_STATUS.ACTIVE
                  ? Container(
                      height: 30,
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'images/active.png',
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  : Container(
                      height: 30,
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'images/inactive.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
            ],
          ),
          subtitle: widget.subTitle,
          trailing:
              Icon(_isExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          children: widget.dhtList == null
              ? Text('NULL')
              : widget.dhtList.map((element) {
                  return ListTileExpandWidget(
                    dht: element,
                  );
                }).toList(),
        ),
      ),
      // children: [
      //   widget.dhtList.isEmpty
      //       ? Text('DHT is Empty')
      //       : Text('DHT is not Empty'),
      //   widget.lightList.isEmpty
      //       ? Text('Light is Empty')
      //       : Text('Light is not Empty'),
      // ],
    );
  }

  showDialogConfirmOTP() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Center(
                    child: SvgPicture.asset(
                  'images/otp.svg',
                  width: 50,
                )),
                content: Container(
                  decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
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
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter OTP';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    controller: _OtpController,
                    obscureText: _isVisiblePass,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isVisiblePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              print('setSTATE');

                              _isVisiblePass = !_isVisiblePass;
                            });
                          }),
                      border: InputBorder.none,
                      hintText: 'Confirm OTP',
                    ),
                  ),
                ),
                actions: [
                  RaisedButton(
                    onPressed: () {
                      if (_OtpController.text.isEmpty) {
                        return;
                      }

                      Provider.of<Devices>(context, listen: false)
                          .confirmOtp(_OtpController.text, '9')
                          .then((value) {
                        Map response = jsonDecode(value.body);
                        bool result = response['responseMessage'];
                        print('OTP RESPONSE => ' + value.body);
                        // bool resBool = response['responseMessage'];
                        if (result != null) {
                          Provider.of<Devices>(context, listen: false)
                              .fetchData();
                          Navigator.of(context).pop();
                        } else {}
                      });
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          );
        });
  }
}
