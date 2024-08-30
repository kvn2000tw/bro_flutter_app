
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_util.dart';
import 'package:bro_flutter_app/manufacture_check/manufacture_check_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/svg.dart';


class ManufactureCheckItemWidget extends StatefulWidget {
  ManufactureCheckItemWidget({super.key,
  required this.checkable,
  required this.datetimeSelect,
  required this.checkSelect,
  required this.note,
  });

  late ValueNotifier<String> datetimeSelect;
  late ValueNotifier<int> checkSelect;
  late TextEditingController note;
  late Map<String,dynamic> checkable;
   
  @override
  State<ManufactureCheckItemWidget> createState() => _ManufactureCheckItemWidgetState();
}

class _ManufactureCheckItemWidgetState extends State<ManufactureCheckItemWidget> {
  late ManufactureCheckItemModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.000000Z");
    DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm");

  @override
  void initState() {
    super.initState();
      _model = createModel(context, () => ManufactureCheckItemModel());

    widget.checkSelect.value = 0;
    if(widget.checkable['value'] == null){

    }
    else if(widget.checkable['value']){
      widget.checkSelect.value = 1;
    }
    else {
      widget.checkSelect.value = 2;
    }

    _model.textController1 ??= TextEditingController(text:widget.checkable['name'].toString());
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController( text:widget.checkable['metadata']['check_station'].toString());
    _model.textFieldFocusNode2 ??= FocusNode();
/*
    _model.textController3 ??= TextEditingController(text:widget.info.expect_weight);
    _model.textFieldFocusNode3 ??= FocusNode();
*/

    DateTime dateTime = dateFormat.parse(widget.checkable['recorded_at'] ?? '2024-07-24T00:00:00.000000Z');
    dateTime = dateTime.add(Duration(hours: 8));
    widget.datetimeSelect.value = dateFormat1.format(dateTime);

  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


  Widget _radioButtonBuilder(BuildContext context,int selectedItem,Widget? child){
var radioItems = <RadioListTile>[];
 radioItems.add(
  RadioListTile(
    value:1,
    groupValue: widget.checkSelect.value,
    title:Text('合格',style:const TextStyle(fontSize: 14)),
    onChanged:(value)=>widget.checkSelect.value = value
  )
 );

 radioItems.add(
  RadioListTile(
    value:2,
    groupValue: widget.checkSelect.value,
    title:Text('瑕疵備註',style:const TextStyle(fontSize: 14)),
    onChanged:(value)=>widget.checkSelect.value = value
  )
 );
return
Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child:radioItems[0]
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
                           child:radioItems[1]
                        ),
                      ),
                    ],
                  );
  }
  Widget _dateButtonBuilder(BuildContext context,String selectedItem,Widget? child){

    final now = DateTime.now();
    final minDate = DateTime(now.year, now.month, now.day, 0, 0);
    final maxDate = DateTime(2030, 5, 5, 20, 50);

    return TextButton(
    onPressed: () {
       DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: minDate,
                      maxTime: maxDate, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                    widget.datetimeSelect.value = dateFormat1.format(date);
                   
                  }, locale: LocaleType.zh,
                  currentTime:DateTime.now()) ;
                },
    child: Text(
        widget.datetimeSelect.value,
        style: TextStyle(color: Colors.blue),
    ));
  }

  @override
  Widget build(BuildContext context) {

// Generated code for this Container Widget...
return // Generated code for this Container Widget...
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
  child: Container(
    width: double.infinity,
    height: 510,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(-1, 1),
                      child: Text(
                        '項目名稱',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
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
                      controller: _model.textController1,
                      focusNode: _model.textFieldFocusNode1,
                      autofocus: false,
                      readOnly: true,
                      obscureText: false,
                      decoration: InputDecoration(
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
                      validator: _model.textController1Validator
                          .asValidator(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 1),
                    child: Text(
                      '狀態',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: ValueListenableBuilder<int> (
                    builder:_radioButtonBuilder,
                    valueListenable:widget.checkSelect
                  )
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 1),
                    child: Text(
                      '檢測站點',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
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
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
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
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        validator: _model.textController2Validator
                            .asValidator(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(-1, 1),
                      child: Text(
                        '時間戳記',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                      ),
                    ),
                  ),
                ),
// Generated code for this Container Widget...
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
                    builder:_dateButtonBuilder,
                    valueListenable:widget.datetimeSelect
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
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(-1, 1),
                      child: Text(
                        '備註',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: widget.note,
                      focusNode: _model.textFieldFocusNode4,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
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
                      validator: _model.textController4Validator
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
);
  }
}
