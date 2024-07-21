
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_order_items/transport_order_item_widget.dart';

import 'package:bro_flutter_app/utils/show_button.dart';

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
 
  required this.lots,
  required this.lots_meta});

  late List<dynamic> lots;
  late dynamic lots_meta;
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
    for(var i = 0; i < widget.lots.length; i++){
        list.add(TransportOrderItemWidget(index:i,lot:widget.lots[i]));
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
                          '總重量:${widget.lots_meta["total_weight"]} kg',
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
                          '總數量:${widget.lots_meta["total_item"]}',
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
                 
              ShowButton(show:widget.canRequest,title:'結算',onPressed:widget.requestPressed),
              ShowButton(show:widget.canReturn,title:'開始回程',onPressed:widget.returnPressed),
              ShowButton(show:widget.canFinish,title:Data.is_product?'完成再製':'結束運輸',onPressed:widget.finishPressed)                   
            ]);
  }
}
