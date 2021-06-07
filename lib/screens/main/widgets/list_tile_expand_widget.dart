import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sm_home_nbcha/models/dht_model.dart';
import 'package:sm_home_nbcha/providers/devices.dart';

class ListTileExpandWidget extends StatefulWidget {
  // final String title;
  // final String subTitle;
  // final Widget icon;
  // final String id, status, isOnline, tempeature, moisture;
  final Dht dht;

  const ListTileExpandWidget({
    Key key,
    this.dht,
    // this.title,
    // this.subTitle,
    // this.icon,
    // this.id,
    // this.status,
    // this.isOnline,
    // this.tempeature,
    // this.moisture,
  }) : super(key: key);

  @override
  _ListTileExpandWidgetState createState() => _ListTileExpandWidgetState();
}

class _ListTileExpandWidgetState extends State<ListTileExpandWidget> {
  bool _isExpand = false;
  var _isInit = true;
  var _isLoading = false;
  var _isSwitchToggle1 = false;
  var _isSwitchToggle2 = false;
  var _isSwitchToggle3 = false;
  var _isSwitchToggle4 = false;
  // bool _isSubToggle = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(
        bottom: 10,
        right: 10,
        left: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpand = !_isExpand;
          });
        },
        leading: CircleAvatar(
          backgroundColor: Colors.yellow[300],
          radius: 40,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('images/temperature.svg'),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.dht.name),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.dht.isOnline == DEVICE_ONLINE
                      ? Container(
                          height: 25,
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'images/active.png',
                            fit: BoxFit.scaleDown,
                          ),
                        )
                      : Container(
                          height: 25,
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'images/inactive.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Text('Machine ID : ' + widget.dht.dhtId),
        trailing: Icon(_isExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.symmetric(
                inside: BorderSide(width: 1),
              ),
              children: [
                TableRow(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text('Status'),
                          Switch(
                              value: _isSwitchToggle1,
                              onChanged: (val) {
                                setState(() {
                                  _isSwitchToggle1 = val;
                                });
                              }),
                        ],
                      ),
                    ),
                    Center(
                      child: widget.dht.status == DEVICE_ONLINE.ACTIVE
                          ? Container(
                              height: 20,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'images/active.png',
                                fit: BoxFit.scaleDown,
                              ),
                            )
                          : Container(
                              height: 20,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'images/inactive.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Center(child: Text('Temperature')),
                    Center(child: Text(widget.dht.temperature)),
                  ],
                ),
                TableRow(
                  children: [
                    Center(child: Text('Moisture')),
                    Center(child: Text(widget.dht.moisture)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 8,
          )
          // ListTile(
          //   title: Text('Temperature'),
          //   trailing: Container(
          //     margin: EdgeInsets.only(right: 10),
          //     child: Text(
          //       widget.dht.temperature,
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: Text('Humidity'),
          //   trailing: Container(
          //     margin: EdgeInsets.only(right: 10),
          //     child: Text(
          //       widget.dht.moisture,
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
    // ListTile(
    //         leading: SvgPicture.asset('images/lamp.svg'),
    //         title: Text(
    //           'Light bulb 1',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         trailing: Switch(
    //           activeColor: Colors.green,
    //           value: _isSwitchToggle1,
    //           onChanged: (value) {
    //             setState(() {
    //               _isSwitchToggle1 = value;
    //             });
    //           },
    //         ),
    //       ),
    //       ListTile(
    //         leading: SvgPicture.asset('images/lamp.svg'),
    //         title: Text(
    //           'Light bulb 2',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         trailing: Switch(
    //           activeColor: Colors.green,
    //           value: _isSwitchToggle2,
    //           onChanged: (value) {
    //             setState(() {
    //               _isSwitchToggle2 = value;
    //             });
    //           },
    //         ),
    //       ),
    //       ListTile(
    //         leading: SvgPicture.asset('images/lamp.svg'),
    //         title: Text(
    //           'Light bulb 3',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         trailing: Switch(
    //           activeColor: Colors.green,
    //           value: _isSwitchToggle3,
    //           onChanged: (value) {
    //             setState(() {
    //               _isSwitchToggle3 = value;
    //             });
    //           },
    //         ),
    //       ),
    //       ListTile(
    //         leading: SvgPicture.asset('images/lamp.svg'),
    //         title: Text(
    //           'Light bulb 4',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         trailing: Switch(
    //           activeColor: Colors.green,
    //           value: _isSwitchToggle4,
    //           onChanged: (value) {
    //             setState(() {
    //               _isSwitchToggle4 = value;
    //             });
    //           },
    //         ),
    //       ),
          // ListTile(
          //   title: Text('Status'),
          //   trailing:
          // ),