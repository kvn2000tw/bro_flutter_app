// TODO Implement this library.import '/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/show_order_status.dart';

import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class TransportOrderBriefOne extends StatefulWidget {
   TransportOrderBriefOne({super.key,
  required this.icon,
  required this.title});

  late String icon;
  late String title;
  

  @override
  State<TransportOrderBriefOne> createState() => _TransportOrderBriefOneState();
}

class _TransportOrderBriefOneState extends State<TransportOrderBriefOne> {


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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:  SvgPicture.asset(
                            widget.icon,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)
                            ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        widget.title,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
  }
}
