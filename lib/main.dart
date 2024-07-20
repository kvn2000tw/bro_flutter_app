
import 'package:bro_flutter_app/camera/take_picture_screen.dart';
import 'package:bro_flutter_app/login/login.dart';
import 'package:bro_flutter_app/page/home_page.dart';
import 'package:bro_flutter_app/page/transport_lot_status_page.dart';
import 'package:bro_flutter_app/page/transport_order_status_page.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info_page.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> _cameras;
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await FlutterFlowTheme.initialize();

  _cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Login(),
      initialRoute: "/",
      routes: {
        "/home" : (context) =>  HomePage(),
        "/transport-order-info" : (context) =>  TransportOrderInfoPage(),
        "/transport-lot-info" : (context) =>  TransportLotStatusPage(),
        "/transport-order-status" : (context) => const TransportOrderStatusPage(), 
        
        "/" :  (context) => Login(),
        "/camera" :  (context) => TakePictureScreen(camera: _cameras.first),
      },
     
    ));
  }

  void setLocale(String language) {
    //setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode)  {
  }
  
  static MyApp of(BuildContext context) {
    return MyApp();
  }

}