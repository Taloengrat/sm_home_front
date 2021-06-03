import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:sm_home_nbcha/models/dht_model.dart';
import 'package:sm_home_nbcha/models/light_model.dart';
import 'package:sm_home_nbcha/models/pi_model.dart';

class DeviceCardList extends StatefulWidget {
  final Widget icon;
  final DEVICE_STATUS status;
  final String title;
  final Widget subTitle;
  final Function function;
  final List<Dht> dhtList;
  final List<Light> lightList;

  const DeviceCardList({
    Key key,
    this.icon,
    this.title,
    this.status,
    this.subTitle,
    this.function,
    this.dhtList,
    this.lightList,
  }) : super(key: key);

  @override
  _DeviceCardListState createState() => _DeviceCardListState();
}

class _DeviceCardListState extends State<DeviceCardList> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
        trailing: Icon(_isExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down),
      ),
      // children: [
      //   // widget.dhtList.isEmpty
      //   //     ? Text('DHT is Empty')
      //   //     : Text('DHT is not Empty'),
      //   // widget.lightList.isEmpty
      //   //     ? Text('Light is Empty')
      //   //     : Text('Light is not Empty'),
      // ],
      // children: widget.dhtList == null
      //     ? Text('NULL')
      //     : widget.dhtList.map((element) {
      // print('element: ' + element.temperature);
      //   return ListTileExpandWidget(
      //       // title: 'ESP',
      //       // subTitle: element.id == null ? 'emp' : element.id,
      //       // icon: SvgPicture.asset('images/circuit.svg'),
      //       // id: element.id == null ? 'emp' : element.id,
      //       // status: element.status == null ? 'emp' : element.status,
      //       // isOnline: element.isOnline == null ? 'emp' : element.isOnline,
      //       // tempeature:
      //       //     element.temperature == null ? 'emp' : element.temperature,
      //       // moisture: element.moisture == null ? 'emp' : element.moisture,
      //       );
      // }).toList(),
    );
  }
}
