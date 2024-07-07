
import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_widget.dart';
import 'package:bro_flutter_app/transport_orders_status/transport_orders_status_item.dart';
import 'package:bro_flutter_app/transport_orders_status/transport_orders_status_item_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bro_flutter_app/runing_page.dart';
import 'package:bro_flutter_app/transport_orders_list/transport_orders_list_widget.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';

class TransportOrdersStatusPage extends StatefulWidget {
  const TransportOrdersStatusPage({super.key});

  @override
  State<TransportOrdersStatusPage> createState() =>
      _TransportOrdersStatusState();
}

class _TransportOrdersStatusState
    extends State<TransportOrdersStatusPage> {
 

  bool canCheck = false;
  bool canFinish = false;
  bool isLoad = true;
  List<RadioGroupController> radio_list = [];
  List<TextEditingController> text_list = [];
  List<Widget> list = [];
  TextEditingController noteController = TextEditingController();

  _getLotStatus()async{
    final response = await Service.getLotStatus(Data.lot_barcode);

    if(response.statusCode == HttpStatus.ok){
      
     setState(() {
      
      initLotStatus();
    });
    }
  }
  initLotStatus(){

    canCheck = Data.isCurrent && (Data.lotStatus.status == lot_status.DISPATCHED.value);
    isLoad = false;

    if(canCheck == true){
        canFinish = true;
        for(var i = 0; i < Data.lotStatus.checkables.length; i++){
          if(Data.lotStatus.checkables[i]["value"] == null){
            canFinish = false;
            break;
          }
        }
      }

      radio_list = [];
      text_list = [];
      noteController = TextEditingController(text:Data.lotStatus.note);

      for(var i = 0; i < Data.lotStatus.checkables.length; i++){
        var radio = RadioGroupController();

        radio_list.add(radio);
        text_list.add(TextEditingController(text:Data.lotStatus.checkables[i]['note']));
        
      }
    
    list = [];
    for(var i = 0; i < Data.lotStatus.checkables.length; i++){
       
        list.add(TransportOrdersStatusItem(info:Data.lotStatus.checkables[i],
        radio:radio_list[i],
        value:Data.lotStatus.checkables[i]["value"],
        textController:text_list[i],
        canCheck:canCheck
      ));
        
    }

    list.add(TransportOrdersStatusItemInfo(info:Data.lotStatus,
    textController:noteController
    ));

  }
  @override
  void initState() {
    super.initState();
    isLoad = true;
    _getLotStatus();
  }

  @override
  void dispose() {
   
    super.dispose();
  }

Future<void> _showMyDialog(String title,String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  saveCheck()async{
    
    for(var i = 0; i < Data.lotStatus.checkables.length; i++){
       
      print(radio_list[i].value);
      print(text_list[i].text);
      print(noteController.text);
      if(radio_list[i].value == null){
        _showMyDialog('檢查錯誤','請點選合格或不合格');
        return;
      }
        
    }

    Map<String,dynamic> data = {};
    List<Map<String,dynamic>> list = [];
    for(var i = 0; i < Data.lotStatus.checkables.length; i++){
      Map<String,dynamic> val = {};
      val['id'] = Data.lotStatus.checkables[i]['id'];
      val['value'] = radio_list[i].value == '合格' ? true:false;
      val['note'] = text_list[i].text;
      list.add(val);
    }
    data["checkable"] = list;
    data['note'] = noteController.text;
    bool ret = await Service.updateLot(Data.lotStatus.barcode,data);

    if(ret == true){
       _showMyDialog('儲存檢查結果','儲存成功');
     setState(() {
      
      initLotStatus();
    });
    }
      
  }
Future<void> _takePicture(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('完成檢查？'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('將儲存物料檢查結果'),
              Text('需要一張物料狀態的照片'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('上傳物料狀態的照片'),
            onPressed: () async{
              
              Data.runFunc = 'passed';
              await Navigator.pushNamed(context,'/camera');
              print('abcd');
              Navigator.of(context).pop();
            },
          ),
           TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
  
  @override
  Widget build(BuildContext context) {

     return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          backgroundColor: Colors.blue,
          elevation:10,
          title: Text('',
          style: TextStyle(color:Colors.white),)
        ),
      body:  isLoad == true ? Container():Column(
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
                     InkWell(
        onTap: (){
         
           Navigator.pop(context);
         
          
        },     child:
                     Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/iconLeftArrow_3x.png',
            ).image,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/iconLeftArrow_3x.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    )),
                    Expanded(
                      child: Container(
                        width: 100,
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
                              '物料資訊',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 24,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
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
                  children: list,
                ),
              ),
              canFinish == false ? Container():Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: FFButtonWidget(
      onPressed: () async{
        print('Button pressed ...');
        await _takePicture(context);
        print('_takePicture');
        setState(() {
      
          initLotStatus();
        });
      },
      text: '完成檢查',
      options: FFButtonOptions(
        height: 40,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primaryBackground,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).primary,
              letterSpacing: 0,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
),
              canCheck == false ? Container() : Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
        saveCheck();
      },
      text: '儲存檢查結果',
      options: FFButtonOptions(
        height: 40,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primaryBackground,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).primary,
              letterSpacing: 0,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: '修改重量',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0,
                              ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
     
    );
  }
}


