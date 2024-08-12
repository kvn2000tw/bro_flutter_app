import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/manufacture_info/manufacture_detail_model.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:bro_flutter_app/utils/show_button.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/svg.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';


class ManufactureDetailWidget extends StatefulWidget {
  ManufactureDetailWidget({super.key,
  required this.info,
   this.canFinish = false,
  
  this.onPressed,
  });

  late ManufactureInfo info;
  late bool canFinish;  
  
  final VoidCallback? onPressed; 
  @override
  State<ManufactureDetailWidget> createState() => _ManufactureDetailWidgetState();
}

class _ManufactureDetailWidgetState extends State<ManufactureDetailWidget> {
  late ManufactureModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String CalculatorIcon = 'assets/images/calculator.svg';
  bool canSave = true;

  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.000000Z");
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm");

  ValueNotifier<String> datetimeStart = ValueNotifier('');
  ValueNotifier<String> datetimeEnd = ValueNotifier('');
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManufactureModel());

    _model.textController1 ??= TextEditingController(text:widget.info.name.toString());
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController( text:widget.info.unit.toString());
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController(text:widget.info.expect_weight);
    _model.textFieldFocusNode3 ??= FocusNode();

    DateTime dateTime = dateFormat.parse(widget.info.expect_started_at);

    datetimeStart.value = dateFormat1.format(dateTime);
    _model.textController4 ??= TextEditingController( text:dateFormat1.format(dateTime));
    _model.textFieldFocusNode4 ??= FocusNode();

    dateTime = dateFormat.parse(widget.info.expect_ended_at);
    datetimeEnd.value = dateFormat1.format(dateTime);
    _model.textController5 ??= TextEditingController( text:dateFormat1.format(dateTime));
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController(text:widget.info.background_emissions_percent.toString());
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController(text:widget.info.production_line["name"] ?? '');
    _model.textFieldFocusNode7 ??= FocusNode();

    _model.textController8 ??= TextEditingController(text:widget.info.description);
    _model.textFieldFocusNode8 ??= FocusNode();

    _model.textController9 ??= TextEditingController(text:widget.info.note);
    _model.textFieldFocusNode9 ??= FocusNode();

  }

 savePressed()async{
  
    Map<String,dynamic> map = 
    {"background_emissions_percent": _model.textController6.text, 
    "description": _model.textController8.text, 
    "expect_ended_at": datetimeEnd.value, 
    "expect_started_at": datetimeStart.value, 
    "expect_weight": _model.textController3.text, 
    "name": _model.textController1.text, 
    "note": _model.textController9.text, 
    "production_line": _model.textController7.text, 
    "production_line_id": widget.info.production_line["id"],
    "unit": _model.textController2.text};

    await Service.updateManufacture(widget.info.id,map);

    if(Data.httpRet){
      showNotification('修改再製單資訊', '完成');
    }
    
  }
  
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: builder(context),
          ),
        ),
      ),
    ShowButton(show:widget.canFinish,title:'完成再製',onPressed:widget.onPressed),
    ShowButton(show:canSave,title:'儲存資料',onPressed:savePressed),
   
  ]);
  }
  
    Widget _datetimeStartButtonBuilder(BuildContext context,String selectedItem,Widget? child){

    return TextButton(
    onPressed: () {
       DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 5, 5, 20, 50),
                      maxTime: DateTime.now(), onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                    datetimeStart.value = dateFormat1.format(date);
                  }, locale: LocaleType.zh,
                  currentTime:DateTime.now()) ;
                },
    child: Text(
        datetimeStart.value,
        style: TextStyle(color: Colors.blue),
    ));
  }
    Widget _datetimeEndButtonBuilder(BuildContext context,String selectedItem,Widget? child){

    return TextButton(
    onPressed: () {
       DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 5, 5, 20, 50),
                      maxTime: DateTime.now(), onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                    datetimeEnd.value = dateFormat1.format(date);
                  }, locale: LocaleType.zh,
                  currentTime:DateTime.now()) ;
                },
    child: Text(
        datetimeEnd.value,
        style: TextStyle(color: Colors.blue),
    ));
  }

  Widget builder(BuildContext context) {

    // Generated code for this Container Widget...
return // Generated code for this Container Widget...
// Generated code for this ListView Widget...
ListView(
  padding: EdgeInsets.zero,
  scrollDirection: Axis.vertical,
  children: [
    Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(-1, 0),
        child: Text(
          '詳細資訊',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Readex Pro',
                fontSize: 20,
                letterSpacing: 0,
              ),
        ),
      ),
    ),
    Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Text(
            '名稱',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0,
                ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: TextFormField(
              controller: _model.textController1,
              focusNode: _model.textFieldFocusNode1,
              autofocus: false,
              obscureText: false,
              readOnly: true,
              decoration: InputDecoration(
                labelText: '',
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0,
                  ),
              validator: _model.textController1Validator.asValidator(context),
            ),
          ),
        ),
      ],
    ),
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            width: 100,
            height: 100,
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
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '產能單位',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: _model.textController2,
                      focusNode: _model.textFieldFocusNode2,
                      autofocus: false,
                      obscureText: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
        ),
        Expanded(
          child: Container(
            width: 100,
            height: 100,
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
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '預估產能',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: _model.textController3,
                      focusNode: _model.textFieldFocusNode3,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                       keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
        ),
      ],
    ),
    Container(
      width: 100,
      height: 100,
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
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Text(
              '預期開始時間',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0,
                  ),
            ),
          ),
Container(
  width: double.infinity,
  height: 50,
  decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
    border: Border.all(
      color: FlutterFlowTheme.of(context).primaryText,
    ),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child:
          ValueListenableBuilder<String> (
                    builder:_datetimeStartButtonBuilder,
                    valueListenable:datetimeStart
                  )
        ),
      ),
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SvgPicture.asset(
            'assets/images/calculator.svg',
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
)
        ],
      ),
    ),
    Container(
      width: 100,
      height: 100,
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
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                '預期結束時間',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
              ),
            ),
          ),
Container(
  width: double.infinity,
  height: 50,
  decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
    border: Border.all(
      color: FlutterFlowTheme.of(context).primaryText,
    ),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child:
          ValueListenableBuilder<String> (
                    builder:_datetimeEndButtonBuilder,
                    valueListenable:datetimeEnd
                  )
        ),
      ),
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SvgPicture.asset(
            'assets/images/calculator.svg',
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
)        ],
      ),
    ),
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            width: 100,
            height: 100,
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
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '背景能耗',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: _model.textController6,
                      focusNode: _model.textFieldFocusNode6,
                      autofocus: false,
                      obscureText: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                      validator: _model.textController6Validator
                          .asValidator(context),
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
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '產線',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: _model.textController7,
                      focusNode: _model.textFieldFocusNode7,
                      autofocus: false,
                      obscureText: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                      validator: _model.textController7Validator
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
    Container(
      width: 100,
      height: 150,
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
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                '再製單敘述',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: TextFormField(
                controller: _model.textController8,
                focusNode: _model.textFieldFocusNode8,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: '',
                  labelStyle:
                      FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                  hintStyle:
                      FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                validator:
                    _model.textController8Validator.asValidator(context),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 100,
      height: 150,
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
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                '備註',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: TextFormField(
                controller: _model.textController9,
                focusNode: _model.textFieldFocusNode9,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: '',
                  labelStyle:
                      FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                  hintStyle:
                      FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                validator:
                    _model.textController9Validator.asValidator(context),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
);



  }
}
