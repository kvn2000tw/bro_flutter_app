
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:bro_flutter_app/utils/show_button.dart';
import 'package:bro_flutter_app/utils/show_order_status.dart';
import 'package:bro_flutter_app/utils/show_save_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'transport_order_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransportOrderWidget extends StatefulWidget {
  TransportOrderWidget({super.key,
  required this.info,
  this.canRequest = false,
  this.canReturn = false,
  this.canStart = false,
  this.canFinish = false,
  this.startPressed,    
  this.requestPressed,
  this.returnPressed,
  this.finishPressed,
  required this.model
  });

  late TransportOrderModel model;
  late TransportOrdersInfo info;
  late bool canRequest;
  late bool canReturn;
  late bool canStart;
  late bool canFinish;  
  final VoidCallback? startPressed;  
  final VoidCallback? requestPressed;
  final VoidCallback? returnPressed;
  final VoidCallback? finishPressed; 
  
  @override
  State<TransportOrderWidget> createState() => _TransportOrderWidgetState();
}

class _TransportOrderWidgetState extends State<TransportOrderWidget> {
  //late TransportOrderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _saveButton()async {

    print( widget.model.textController1.text);
    print( widget.model.textController2.text);
    print( widget.model.textController3.text);
    var start = double.tryParse(widget.model.textController1.text) ?? 0;
    var end = double.tryParse(widget.model.textController2.text) ?? 0;

    FocusManager.instance.primaryFocus?.unfocus();

    if(widget.info.isgmap == 0 &&  start >= end){
      showAlert(context,'結束里程','需大於起始里程數');
      return;
      
    }
    await Service.updatEodometer(widget.info.isgmap,start, end, widget.model.textController3.text);
  
    if(Data.httpRet == true){
      showNotification('儲存資料', '成功');
      
    }else {
      showAlert(context,'儲存資料',Data.errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    /*
    _model = createModel(context, () => TransportOrderModel());

    _model.textController1 ??= TextEditingController(text:widget.info.initial_odometer.toString());
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController( text:widget.info.final_odometer.toString());
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController(text:widget.info.note);
    _model.textFieldFocusNode3 ??= FocusNode();
*/
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }
  

  final String ArrowRightIcon = 'assets/images/arrow-right.svg';
  
  @override
  Widget build(BuildContext context) {

    return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
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
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  widget.info.custom_id,
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
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child:ShowOrderStatus(status:widget.info.status),
                             )),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Container(
                                width: 250,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 258,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Text(
                                        widget.info.manufacturer,
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
                                    Container(
                                      width: 212,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Text(
                                       widget.info.address_from,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 100,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                             child: SvgPicture.asset(
                        ArrowRightIcon,
                        colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),),
                        ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Container(
                                width: 250,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 258,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Text(
                                        widget.info.organization,
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
                                    Container(
                                      width: 212,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Text(
                                        widget.info.address_to,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  distance(context),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: Container(
                              width: double.infinity,
                              height: 20,
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
                                      letterSpacing: 0,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: TextFormField(
                                         readOnly: false,
                                        controller: widget.model.textController3,
                                        focusNode: widget.model.textFieldFocusNode3,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0,
                                                  ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                            ),
                                        textAlign: TextAlign.start,
                                        maxLines: 8,
                                        validator: widget.model
                                            .textController3Validator
                                            .asValidator(context),
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
                  ),
                  ShowButton( show:widget.canStart,title:'開始運輸',onPressed:widget.startPressed),
                  ShowButton(show:widget.canReturn,title:'開始回程',onPressed:widget.returnPressed),
                  ShowButton(show:widget.canRequest,title:'結算',onPressed:widget.requestPressed),
                  ShowButton(show:widget.canFinish,title:'結束運輸',onPressed:widget.finishPressed),
                  ShowSaveButton(show:Data.isCurrent,title:'儲存資料',onPressed:_saveButton),

                ],
              ),
            ),
          );
        
  }
  Widget distance(BuildContext context){
    List<Widget> list = [];

    if(widget.info.isgmap == 1){
      list.add(inputWrap(context,'google map 里程',
                  widget.model.textController4,
                  widget.model.textFieldFocusNode4,
                  widget.model.textController4Validator,true));

    }else {
      list.add(inputWrap(context,'起始里程',
                  widget.model.textController1,
                  widget.model.textFieldFocusNode1,
                  widget.model.textController1Validator,
                  false));
    list.add(
                  inputWrap(context,'結束里程',
                  widget.model.textController2,
                  widget.model.textFieldFocusNode2,
                  widget.model.textController2Validator,
                  false));
    }
    return Column(
      children:list
    );
  }
  Padding inputWrap(BuildContext context,
  String name,
  TextEditingController? textController1,
  FocusNode  textFieldFocusNode1,
  String? Function(BuildContext, String?)? textController1Validator,
  bool readyonly) {
    return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Text(
                              name,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: TextFormField(
                                      readOnly: readyonly,
                                      controller: textController1,
                                      focusNode: textFieldFocusNode1,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                        hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0,
                                          ),
                                      keyboardType: TextInputType.number,    
                                      validator: textController1Validator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Text(
                                    '公里',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
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
                );
  }
}
