import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'transport_orders_detail_item_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransportOrdersDetailItemWidget extends StatefulWidget {
   TransportOrdersDetailItemWidget({super.key,
  
  required this.lot,
  required this.index});

  late int index;
  late Map<String,dynamic> lot; 
  @override
  State<TransportOrdersDetailItemWidget> createState() => _TransportOrdersDetailItemWidgetState();
}

class _TransportOrdersDetailItemWidgetState extends State<TransportOrdersDetailItemWidget> {
  late TransportOrdersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late String status;
  late Color color;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransportOrdersModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    status = SearchIcon;
    color = Colors.blue;

    _initStatus();

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  final String SearchIcon = 'assets/images/search.svg';

  final String CheckIcon = 'assets/images/check-circle.svg';
  final String ExclamationIcon = 'assets/images/exclamation-circle.svg';
 
  _initStatus(){
    int this_status = Data.transport_info.lots[widget.index]['status'];
    status = SearchIcon;
   if( this_status == lot_status.PASSED.value){
      status = CheckIcon;
      color = Colors.green;
   }else if(this_status == lot_status.REQUESTED.value){
      status = SearchIcon;
      color = Colors.blue;
   }
   else if(this_status == lot_status.FAILED.value){
      status = ExclamationIcon;
      color = Colors.red;
   }
  
  }
  @override
  Widget build(BuildContext context) {
   
    return           
    InkWell(
        onTap: ()async{
          print("alarm clicked");
          Data.lot_barcode = widget.lot['barcode'];
          await Navigator.pushNamed(context,'/transport-orders-status');
          setState(() {

            _initStatus();
          });

        },        
          child:   Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  widget.lot['barcode'],
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:SvgPicture.asset(
                            status,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  '容器：${widget.lot['container']}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  '體積：${widget.lot['volume']}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  '重量：${widget.lot['weight']} kg',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  '產品描述：${widget.lot['description']}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 18,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
