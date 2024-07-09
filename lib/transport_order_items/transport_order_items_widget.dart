
import 'package:bro_flutter_app/transport_order_items/transport_order_item_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/finish_button.dart';
import 'package:bro_flutter_app/utils/request_button.dart';
import 'package:bro_flutter_app/utils/return_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';


class TransportOrderItemsWidget extends StatefulWidget {
  TransportOrderItemsWidget({super.key,
  this.canRequest = false,
  this.canReturn = false,
  this.canFinish = false,
  this.requestPressed,
  this.returnPressed,
  this.finishPressed,  
  required this.info});

  late TransportOrdersInfo info;
  late bool canRequest;
  late bool canReturn;
  late bool canFinish;  
  final VoidCallback? requestPressed;
  final VoidCallback? returnPressed;
  final VoidCallback? finishPressed;  
  @override
  State<TransportOrderItemsWidget> createState() => _TransportOrderItemsWidgetState();
}

class _TransportOrderItemsWidgetState extends State<TransportOrderItemsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool canReturn = false;
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
    for(var i = 0; i < widget.info.lots.length; i++){
        list.add(TransportOrderItemWidget(index:i,lot:widget.info.lots[i]));
    }
    return 
 Column(
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '物料清單',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 24,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          '總重量:${widget.info.lots_meta["total_weight"]} kg',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          '總數量:${widget.info.lots_meta["total_item"]}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
             FinishButton(show:widget.canFinish,onPressed:widget.finishPressed)                   
            ]);
  }
}
