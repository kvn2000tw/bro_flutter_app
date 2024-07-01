import 'package:bro_flutter_app/transport_orders/transport_orders_list_widget.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'transport_orders_info_model.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TransportOrdersInfoHeader extends StatefulWidget {
  TransportOrdersInfoHeader({super.key,
  required this.title,
  this.hasReturn,
  this.hasAction, 
  });

  late String title;
  bool? hasReturn;
  bool? hasAction;
  @override
  State<TransportOrdersInfoHeader> createState() => _TransportOrdersInfoHeaderState();
}

class _TransportOrdersInfoHeaderState extends State<TransportOrdersInfoHeader>
    with TickerProviderStateMixin {


  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String CameraIcon = 'assets/images/camera.svg';
  final String QrCodeIcon = 'assets/images/qr-code.svg';

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
                    widget.hasAction != null ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:  SvgPicture.asset(
                        CameraIcon,
                        colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),),
                        ),
                    ):Container(),
                     widget.hasAction != null ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                      child:  SvgPicture.asset(
                        QrCodeIcon,
                        colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),)
                      ),
                    ):Container(),
                  ],
                ),
              );

  }
}
