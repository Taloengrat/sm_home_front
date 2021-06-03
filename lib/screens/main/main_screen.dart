import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sm_home_nbcha/providers/users.dart';
import 'package:sm_home_nbcha/screens/main/components/ProfileCard.dart';
import 'package:sm_home_nbcha/screens/main/components/SearchField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'components/DeviceField.dart';

class Main_screen extends StatefulWidget {
  static const String routeName = 'main-screen';

  Main_screen({Key key}) : super(key: key);

  @override
  _Main_screenState createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {
  bool _isLoading = false;
  bool _isInit = true;
  bool _isMenuOpen = false;
  final piNameController = TextEditingController();
  final statusController = TextEditingController();
  final searchController = TextEditingController();
  final _formCreatePiKey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {});
    // WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;

      var user = Provider.of<Users>(context).item;

      print('ID => ' + user.id);
      Provider.of<Devices>(context)
          .fetchData(user.id, user.token)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  InputDecoration getTextFieldStyle(String labelText) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final device = Provider.of<Devices>(context).item;
    final user = Provider.of<Users>(context, listen: false).item;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: size.width,
        height: size.width,
        child:
            // contain
            Stack(
          children: [
            // Plan picture
            Center(
              child: Container(
                width: size.width * 0.85,
                height: size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 40),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                child: InteractiveViewer(
                  scaleEnabled: true,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/plan.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Header
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Color(0XFFEFF3F6),
                  borderRadius: BorderRadius.circular(48.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        offset: Offset(6, 2),
                        blurRadius: 6.0,
                        spreadRadius: 3.0),
                    BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        offset: Offset(-6, -2),
                        blurRadius: 6.0,
                        spreadRadius: 3.0)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                        // logo
                        child: SvgPicture.asset(
                      'logo.svg',
                      height: 40,
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    RichText(
                      // Text logo
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'SMART HOME\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextSpan(
                            text: 'NBCHA company',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                color: secondaryColor),
                          ),
                        ],
                      ),
                      // 'SMART HOME/nNBCHA company',
                      // style:
                    ),
                    Spacer(),
                    Container(
                      width: 250,
                      child: SearchField(),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 55,
                      width: 55,
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
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              offset: Offset(-6, -2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0)
                        ],
                      ),
                      child: Tooltip(
                        message: 'Notification',
                        child: IconButton(
                            icon: Icon(Icons.notifications), onPressed: () {}),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Center(
                      // Menu

                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: _isMenuOpen ? thirdColor : Color(0XFFEFF3F6),
                          borderRadius: BorderRadius.circular(48.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                offset: Offset(6, 2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                            BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                offset: Offset(-6, -2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0)
                          ],
                        ),
                        child: Tooltip(
                          message: 'Menu',
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                            ),
                            onPressed: () {
                              setState(() {
                                _isMenuOpen = !_isMenuOpen;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    ProfileCard(),
                  ],
                ),
              ),
            ),

            if (_isMenuOpen)
              Positioned(
                top: 90,
                right: 35,
                child: DeviceField(
                  size: size,
                  isLoading: _isLoading,
                  device: device,
                  id: user.id,
                  token: user.token,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
