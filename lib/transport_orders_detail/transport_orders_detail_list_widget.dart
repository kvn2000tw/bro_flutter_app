import 'package:bro_flutter_app/transport_orders_detail/transport_orders_detail_item_widget.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';
import 'package:bro_flutter_app/utils/request_button.dart';
import 'package:bro_flutter_app/utils/return_button.dart';
import 'package:bro_flutter_app/utils/start_button.dart';


import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'transport_orders_detail_list_model.dart';


class TransportOrdersDetailListWidget extends StatefulWidget {
  TransportOrdersDetailListWidget({super.key,
  this.canRequest = false,
  this.canStart = false,
  this.canReturn = false,
  required this.info});

  late TransportOrdersInfo info;
  late bool canRequest;
  late bool canStart;
  late bool canReturn;
  @override
  State<TransportOrdersDetailListWidget> createState() => _TransportOrdersDetailListWidgetState();
}

class _TransportOrdersDetailListWidgetState extends State<TransportOrdersDetailListWidget> {
  late TransportOrdersDetailListModel _model;

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
        list.add(TransportOrdersDetailItemWidget(lot:widget.info.lots[i]));
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
                  StartButton(show:widget.canStart),
                  RequestButton(show:widget.canRequest),
                  ReturnButton(show:widget.canReturn)              
            ]);
  }
}
