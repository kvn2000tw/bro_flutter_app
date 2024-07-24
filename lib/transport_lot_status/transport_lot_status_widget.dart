import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_model.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_lot_status/transport_order_model.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attach_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/dialog.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:bro_flutter_app/utils/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransportLotStatusWidget extends StatefulWidget {
  const TransportLotStatusWidget({super.key});

  @override
  State<TransportLotStatusWidget> createState() =>
      _TransportLotStatusState();
}

class _TransportLotStatusState
    extends State<TransportLotStatusWidget> {

    late TransportLotStatusModel _model;
    bool isLoad = true;
    bool need_change = false;
    final ValueNotifier<bool> status = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    isLoad = true;
    _model = createModel(context, () => TransportLotStatusModel());

   // _model.textController1 ??= TextEditingController(text:widget.info.initial_odometer.toString());
    _model.textFieldFocusNode1 ??= FocusNode();

    //_model.textController2 ??= TextEditingController( text:widget.info.final_odometer.toString());
    _model.textFieldFocusNode2 ??= FocusNode();

    //_model.textController3 ??= TextEditingController(text:widget.info.note);
    _model.textFieldFocusNode3 ??= FocusNode();

    need_change = false;
  }

  @override
  void dispose() {
  _model.dispose();
    super.dispose();
  }

  Future<bool> _getTransportLot()async{
    isLoad = true;
    
   await Service.getTransportWarehouse();
    dropdownValue = Data.warehouse.first;

   final ret = await Service.getLotStatus(Data.lot_barcode);

    for(var i=0;i<Data.warehouse.length;i++){
      if(Data.lotStatus.warehouse_id == Data.warehouse[i].id){
        dropdownValue = Data.warehouse[i];
      }
    }
    String weight = '${Data.lotStatus.weight}';
    _model.textController1 = TextEditingController(text:weight);
    _model.textController2 = TextEditingController(text:Data.lotStatus.description);
    _model.textController3 = TextEditingController(text:Data.lotStatus.note);
    isLoad = false;
    if(Data.lotStatus.warehouse_id == '' || Data.lotStatus.status == 9){
      need_change = true;
    }
   return ret;
}

late WarehouseModel dropdownValue;

  _finishCheck()async{
    Data.runFunc = 'storage';
    await Navigator.pushNamed(context,'/camera');
    
    if (context.mounted){
      Navigator.of(context).pop();
    }

    if(Data.httpRet == true){
      bool ret = await Service.updateLotInfo(_model.textController3!.text,_model.textController1!.text,dropdownValue.id);

      if(ret){
       showNotification('納入倉儲','完成');
      }
      
      print('_takePicture');
    
      setState(() {
        dropdownValue;
        //initLotStatus();
      });
    }

}
_onSave(BuildContext context)async{
  if(dropdownValue.id != Data.lotStatus.warehouse_id){
    String title = '變更物料倉儲？';
    List<String> contents = ['將物料納入 ${dropdownValue.name}','需要一張納入倉儲的照片'];
    String buttonText = '上傳納入倉儲照片';

    showTransportDialog(context, title, contents, buttonText, _finishCheck);
  }else {

  bool ret = await Service.updateLotInfo(_model.textController3!.text,_model.textController1!.text,dropdownValue.id);

  if(ret){
    showNotification('修改','完成');
  }
  }
}
  Widget _DropDownBuilder(BuildContext context, bool selectedButton, Widget? child){
   
     return DropdownButton<WarehouseModel>(
      
      isExpanded: true,
      hint: const Text('選擇倉位'),
      value: Data.lotStatus.warehouse_id == '' ? null : dropdownValue,
      elevation: 16,
      style:FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 21,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
      onChanged: need_change == false ? null : (WarehouseModel? value) {
        // This is called when the user selects an item.
        dropdownValue = value!; 
        Data.lotStatus.warehouse_id = '1';
        status.value = !status.value;
        //dropdownValue = value!;
      },
      items: Data.warehouse.map<DropdownMenuItem<WarehouseModel>>((WarehouseModel value) {
        return DropdownMenuItem<WarehouseModel>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
    
  }
Widget Warehouse(BuildContext context){
        ValueListenableBuilder<bool> _DropDown = ValueListenableBuilder<bool>(
        builder: _DropDownBuilder,
        valueListenable: status,
      );

  return              Wrap(
    children:[ Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      '入庫資訊',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '選擇倉位',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: _DropDown
                    ),
                  ],
                ),
              )]);
}
Widget builder(BuildContext context) {
      List<Widget> list = [];
    for(var i = 0; i < Data.lotStatus.attachments.length; i++){
        list.add(TransportOrderAttachWidget(attach:Data.lotStatus.attachments[i]));
    }

  return 
 // Generated code for this Column Widget...
Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: Container(
          width: double.infinity,
          height: 530,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () { Navigator.of(context).pop();},
                    child:Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/iconLeftArrow_3x.png',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            Data.lotStatus.barcode,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 21,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SvgPicture.asset(
                        'assets/images/camera.svg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                         colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                      ),
                    ),
                  ],
                ),
              ),
              Warehouse(context),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      '詳細資訊',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '名稱',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Text(
                          Data.lotStatus.name,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      Data.lotStatus.container,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      Data.lotStatus.volume,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
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
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '重量',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 24,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                   // Generated code for this Row Widget...
Row(
  mainAxisSize: MainAxisSize.max,
  children: [
    Expanded(
      child: Container(
        width: double.infinity,
        height: 40,
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
            readOnly: !need_change,
            decoration: InputDecoration(
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
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            validator: _model.textController1Validator.asValidator(context),
          ),
        ),
      ),
    ),
    Text(
      'kg',
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            letterSpacing: 0,
          ),
    ),
  ],
)

                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
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
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '產品描述',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
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
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '附件',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 24,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    Expanded(
                    child:Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: 
                      list.length == 0 ? Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Text(
        '無附件檔案',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
      ),
    ),
  ),
):
                      ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: list,
                      ),
                    )),
                ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
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
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '備註',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: _model.textController3,
                          focusNode: _model.textFieldFocusNode3,
                          autofocus: false,
                          obscureText: false,
                          readOnly: !need_change,
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
      ),
    ),
   // Generated code for this Container Widget...
// Generated code for this Container Widget...
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: FFButtonWidget(
      onPressed: need_change == false ? null:() {
        print('Button pressed ...');
        _onSave(context);
      },
      text: '儲存',
      options: FFButtonOptions(
        height: 40,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
              letterSpacing: 0,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
)
  ],
);
}
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: _getTransportLot(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        
        if(isLoad == true)
          return WaitingWidget();

        return builder(context);
      }
    );
   
  }
}


