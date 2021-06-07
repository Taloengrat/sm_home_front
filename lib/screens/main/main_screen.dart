import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sm_home_nbcha/providers/notifications.dart';
import 'package:sm_home_nbcha/screens/main/components/ProfileCard.dart';
import 'package:sm_home_nbcha/screens/main/components/SearchField.dart';
import 'package:http/http.dart' as http;
import 'package:sm_home_nbcha/screens/main/components/symbol_drag_object.dart';
import 'package:sm_home_nbcha/screens/main/paints/overview_home.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sm_home_nbcha/screens/main/paints/roof_home_paint.dart';
import 'dart:ui' as ui;
import 'components/DeviceField.dart';
import 'paints/image_paint.dart';
import 'widgets/notification_badge_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sm_home_nbcha/models/notification_model.dart';

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

  IO.Socket socket;
  String OTPContent = '';

  ui.Image image;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {});
    // WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
    socket = IO.io('https://smarthome-backend-chban.com/');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('WS#OTP#RASPBERRY_PI#9', (data) {
      print('RECEIVE => ' + data.toString());
      Map<String, dynamic> value = data;
      Provider.of<Notifications>(context, listen: false).sendNotification(
        NotificationModel(
            date: DateTime.now().toString(),
            notificationType: NOTIFICATION_TYPE.OTP,
            subTitle: value['otp'].toString(),
            title: 'Receive OTP message'),
      );

      setState(() {
        OTPContent = data['otp'].toString();
      });
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    loadImage('images/circuit.svg');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;

      Provider.of<Devices>(context).fetchData().then((value) {
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
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 120, bottom: 40),
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return InteractiveViewer(
                      scaleEnabled: true,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/plan.jpg'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SymbolDragObject(
                            key: GlobalKey(),
                            initPos: Offset(500, 0.0),
                            id: 'Item 2',
                            itmColor: Colors.pink,
                            scopeArea: Size(
                              constraints.maxWidth,
                              constraints.maxHeight,
                            ),
                            itemWidget: image == null
                                ? CircularProgressIndicator()
                                : Container(
                                    height: 300,
                                    width: 300,
                                    child: FittedBox(
                                      child: SizedBox(
                                        width: image.width.toDouble(),
                                        height: image.height.toDouble(),
                                        child: CustomPaint(
                                          painter: ImagePainter(image),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  })),
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
                      child: NotificationBadgeWidget(),
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

            //Overview home
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 90,
                      child: CustomPaint(
                        size: Size(130, 60),
                        painter: TrianglePainter(),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 120,
                      child: CustomPaint(
                        painter: OverviewHomePainter(),
                        // child: Text(
                        //   "Custom Paint",
                        //   style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                        // ),
                      ),
                    ),
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
                ),
              ),

            if (OTPContent.isNotEmpty)
              Positioned(
                top: 120,
                left: 50,
                child: Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(OTPContent),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    setState(() => this.image = image);
  }
}
