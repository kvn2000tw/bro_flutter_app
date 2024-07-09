
import 'package:bro_flutter_app/flutter_flow/flutter_flow_model.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attach_widget.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attachs_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/transport_order_status/transport_order_status_item_info_model.dart';
import 'package:flutter/material.dart';

class TransportOrderStatusItemInfo extends StatefulWidget {
   TransportOrderStatusItemInfo({super.key,
  required this.info,
  this.textController
  });

  late TransportOrdersLotStatus info;
  TextEditingController? textController;

  @override
  State<TransportOrderStatusItemInfo> createState() =>
      _TransportOrderStatusState();
}

class _TransportOrderStatusState
    extends State<TransportOrderStatusItemInfo> {

       late TransportOrderStatusItemInfoModel _model;
 
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransportOrderStatusItemInfoModel());

    _model.textController1 ??= TextEditingController(text:widget.info.weight);
    _model.textController2 ??= TextEditingController(text:widget.info.description);
    _model.textController3 ??= TextEditingController(text:widget.info.note);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for(var i = 0; i < widget.info.attachments.length; i++){
        list.add(TransportOrderAttachWidget(attach:widget.info.attachments[i]));
    }

     return        
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  width: double.infinity,
                  height: 730,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                        child: Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              '詳細資訊',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 24,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Text(
                                '名稱',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 24,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  widget.info.name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Text(
                                        '容器',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                   Padding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
  child: Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      border: Border.all(
        color: FlutterFlowTheme.of(context).primaryText,
      ),
    ),
    child:Align(
  alignment: AlignmentDirectional(-1, 0),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
    child: Text(
      widget.info.container,
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            letterSpacing: 0,
          ),
    ),
  ),
),
  ),
),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Text(
                                        '體積',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                               Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  child: Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      border: Border.all(
        color: FlutterFlowTheme.of(context).primaryText,
      ),
    ),
    child: Align(
  alignment: AlignmentDirectional(-1, 0),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
    child: Text(
      widget.info.volume,
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            letterSpacing: 0,
          ),
    ),
  ),
),

  ),
),
                                ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Text(
                                '重量',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 24,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                child: TextFormField(
                                  controller: _model.textController1,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                  validator: _model.textController1Validator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Text(
                                '產品描述',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 24,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _model.textController2,
                                  focusNode: _model.textFieldFocusNode2,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                  validator: _model.textController2Validator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: TransportOrderAttachsWidget(attachs:widget.info.attachments),
                      ),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Text(
                                '備註',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 24,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                child: TextFormField(
                                  controller: widget.textController,
                                  focusNode: _model.textFieldFocusNode3,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                  validator: _model.textController3Validator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}


