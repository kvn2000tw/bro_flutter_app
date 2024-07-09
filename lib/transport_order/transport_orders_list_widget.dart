import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'transport_orders_model.dart';


class TransportOrdersListWidget extends StatefulWidget {
  const TransportOrdersListWidget({super.key});

  @override
  State<TransportOrdersListWidget> createState() => _TransportOrdersListWidgetState();
}

class _TransportOrdersListWidgetState extends State<TransportOrdersListWidget> {
  late TransportOrdersModel _model;

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
    return 
     Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        '物料清單',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          '總重量：900.0kg 總數量：3',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [],
                ),
              ),
            ],
          );
  }
}
