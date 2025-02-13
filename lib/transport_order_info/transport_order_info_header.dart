
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:native_qr/native_qr.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';


class TransportOrderInfoHeader extends StatefulWidget {
  TransportOrderInfoHeader({super.key,
  required this.title,
  this.hasReturn,
  this.hasAction, 
  });

  late String title;
  bool? hasReturn;
  bool? hasAction;
  @override
  State<TransportOrderInfoHeader> createState() => _TransportOrderInfoHeaderState();
}

class _TransportOrderInfoHeaderState extends State<TransportOrderInfoHeader>
    with TickerProviderStateMixin {


  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String CameraIcon = 'assets/images/camera.svg';
  final String QrCodeIcon = 'assets/images/qr-code.svg';

  _checkLot(String lot){
    List list = Data.transport_info.lots.where((item) => item['id'] == lot).toList();
    
    if(list.length > 0) 
    {
      Data.lot_barcode = list[0]['barcode'];
      return true;
    }
    return false;
  }
  _scan()async{
  
    try {
  NativeQr nativeQr = NativeQr();
  String? result = await nativeQr.get();  
  print('qr code $result');
  List<String>? list = result?.split('/lots/');

  if(list != null && list.length >= 2){
    bool ret = _checkLot(list[1]);

   if(ret){
     
      await Navigator.pushNamed(context,'/transport-order-status');
     
    return;
   }

   showAlert(context,"錯誤","無此料號");
  }
  
} catch(err) {
  print(err);
}
  }
  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return 
                Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
  widget.hasReturn == null ? Container() : InkWell(
        onTap: (){
         
           Navigator.pop(context);

        },                     // Generated code for this Container Widget...
child:Container(
  width: 50,
  height: 50,
  decoration: BoxDecoration(
    color: FlutterFlowTheme.of(context).secondaryBackground,
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(
      'assets/images/iconLeftArrow_3x.png',
      width: 300,
      height: 200,
      fit: BoxFit.cover,
    ),
  ),
)),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    false ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child:InkWell(
                        onTap: _scan,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:  SvgPicture.asset(
                        CameraIcon,
                        colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),),
                        )),
                    ):Container(),
                     (widget.hasAction != null && widget.hasAction == true) ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: InkWell(
                        onTap: _scan,
                        child:ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                      child:  SvgPicture.asset(
                        QrCodeIcon,
                        colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),)
                      )),
                    ):Container(),
                  ],
                ),
              );

  }
}
