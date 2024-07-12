
import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';

import 'package:bro_flutter_app/transport_order_status/transport_order_status_item.dart';
import 'package:bro_flutter_app/transport_order_status/transport_order_status_item_info.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/dialog.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';

class TransportOrderStatusPage extends StatefulWidget {
  const TransportOrderStatusPage({super.key});

  @override
  State<TransportOrderStatusPage> createState() =>
      _TransportOrderStatusState();
}

class _TransportOrderStatusState
    extends State<TransportOrderStatusPage> {
 

  bool canCheck = false;
  bool canFinish = false;
  bool isLoad = true;
  List<RadioGroupController> radio_list = [];
  List<TextEditingController> text_list = [];
  List<Widget> list = [];
  TextEditingController noteController = TextEditingController();
  TextEditingController weightController = TextEditingController();

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

    canFinish = false;
    
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
      weightController = TextEditingController(text:Data.lotStatus.weight);

      for(var i = 0; i < Data.lotStatus.checkables.length; i++){
        var radio = RadioGroupController();

        radio_list.add(radio);
        text_list.add(TextEditingController(text:Data.lotStatus.checkables[i]['note']));
        
      }
    
    list = [];
    for(var i = 0; i < Data.lotStatus.checkables.length; i++){
       
        list.add(TransportOrderStatusItem(info:Data.lotStatus.checkables[i],
        radio:radio_list[i],
        value:Data.lotStatus.checkables[i]["value"],
        textController:text_list[i],
        canCheck:canCheck
      ));
        
    }

    list.add(TransportOrderStatusItemInfo(info:Data.lotStatus,
    weightController:weightController,
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
    noteController.dispose();
    weightController.dispose();
    super.dispose();
  }

  saveCheck(BuildContext context)async{
    
    for(var i = 0; i < Data.lotStatus.checkables.length; i++){
       
      print(radio_list[i].value);
      print(text_list[i].text);
      print(noteController.text);
      if(radio_list[i].value == null){
        showAlert(context,'檢查錯誤','請點選合格或不合格');
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
  
    await Service.updateLot(Data.lotStatus.barcode,data);
  
    if(Data.httpRet == true){
      showNotification('儲存檢查結果','儲存成功');
      
     setState(() {
      
      initLotStatus();
    });
    }
      
  }
  updateWeight(BuildContext context)async{
    
    Map<String,dynamic> data = {};
   
    data['weight'] = weightController.text;
    //await Service.updateLot(Data.lotStatus.barcode,data);
    await Service.updateLotWeight(Data.lotStatus.barcode,data);

    if(Data.httpRet == true){
      showNotification('修改重量','成功');
      
     setState(() {
      
      initLotStatus();
    });
    }
      
  }


_finishCheck()async{
    Data.runFunc = 'passed';
    await Navigator.pushNamed(context,'/camera');
    print('abcd');
    if (context.mounted){
      Navigator.of(context).pop();
    }

    if(Data.httpRet == true){
      showNotification('完成檢查','完成');
      print('_takePicture');
    
      setState(() {
      
        initLotStatus();
      });
    }

}
Future<void> _takePicture(BuildContext context) async {
  String title = '完成檢查？';
  List<String> contents = ['將儲存物料檢查結果','需要一張物料狀態的照片'];
  String buttonText = '上傳物料狀態的照片';

  showTransportDialog(context, title, contents, buttonText, _finishCheck);
 
}
  
   
  @override
  Widget build(BuildContext context) {

     return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          backgroundColor: Colors.blue,
          elevation:10,
          title: const Text('',
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
  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
      },
      text: '完成檢查',
      options: FFButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
          fontFamily: 'Readex Pro',
          color: Colors.white,
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
  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
        saveCheck(context);
      },
      text: '儲存檢查結果',
      options: FFButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
              Data.isCurrent == false? Container(): Padding(
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
                      updateWeight(context);
                    },
                    text: '修改重量',
                    options: FFButtonOptions(
                      height: 40,
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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


