import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_attach_widget.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';
import 'package:bro_flutter_app/utils/finish_button.dart';
import 'package:bro_flutter_app/utils/request_button.dart';
import 'package:bro_flutter_app/utils/return_button.dart';
import 'package:bro_flutter_app/utils/start_button.dart';


import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'transport_orders_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransportOrdersAttachsWidget extends StatefulWidget {
  TransportOrdersAttachsWidget({super.key,
  required this.attachs,
  this.canRequest=false ,
  this.canReturn=false ,
  this.canFinish=false ,  
  this.requestPressed,
  this.returnPressed,
  this.finishPressed  
  });

  late List<dynamic> attachs;
  late bool canRequest;
  late bool canReturn;
  late bool canFinish;  
  final VoidCallback? requestPressed;
  final VoidCallback? returnPressed;  
  final VoidCallback? finishPressed;    
  @override
  State<TransportOrdersAttachsWidget> createState() => _TransportOrdersAttachtState();
}

class _TransportOrdersAttachtState extends State<TransportOrdersAttachsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

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

    List<Widget> list = [];
    for(var i = 0; i < widget.attachs.length; i++){
        list.add(TransportOrdersAttachWidget(attach:widget.attachs[i]));
    }

    return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '附件',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),  
              ),
                            list.length == 0 ? Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Text(
        '無附件檔案',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
      ),
    ),
  ),
):
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: list,
                ),
              ),
              
              RequestButton(show:widget.canRequest,onPressed:widget.requestPressed),
              ReturnButton(show:widget.canReturn,onPressed:widget.returnPressed),
              FinishButton(show:widget.canFinish,onPressed:widget.finishPressed),
            ],
          );
  }
}
