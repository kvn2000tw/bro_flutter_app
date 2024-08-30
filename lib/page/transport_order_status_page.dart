

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';

import 'package:bro_flutter_app/transport_order_status/transport_order_status_item.dart';
import 'package:bro_flutter_app/transport_order_status/transport_order_status_item_info.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/dialog.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:bro_flutter_app/utils/show_button.dart';
import 'package:bro_flutter_app/utils/waiting_widget.dart';
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

  Future<bool> _getLotStatus()async{
    await Service.getTransportWarehouse();
    final response = await Service.getLotStatus(Data.lot_barcode);
    initLotStatus();
    isLoad = false;
    return true;
  }
  initLotStatus(){

    canCheck = Data.isCurrent && (Data.lotStatus.status >= lot_status.CREATED.value && Data.lotStatus.status <= lot_status.DISPATCHED.value);
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
  
  }

  @override
  void dispose() {
    noteController.dispose();
    weightController.dispose();
    super.dispose();
  }

  saveCheck()async{
    
    for(var i = 0; i < Data.lotStatus.checkables.length; i++){
       
      print(radio_list[i].value);
      print(text_list[i].text);
      print(noteController.text);
      if(radio_list[i].value == null){
        showAlert(context,'檢查錯誤','請點選合格或瑕疵備註');
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
  updateWeight()async{
    
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
      
       
      });
    }
  FocusManager.instance.primaryFocus?.unfocus();

}

Future<void> cancelPicked()async{
  bool ret = await Service.manufacturerCancelPicked();

  if(ret){
    await _getLotStatus();
    await Service.getManufactureInfo();
    showNotification('退回物料', '完成');
         setState(() {
      
     
    });

  }
}
Future<void> picked()async{
  bool ret = await Service.manufacturerPicked();

  if(ret){
    await _getLotStatus();
    await Service.getManufactureInfo();
        showNotification('拿取物料', '完成');
         setState(() {
      
      
    });

  }
}

Future<void> _takePicture() async {
  String title = '完成檢查？';
  List<String> contents = ['將儲存物料檢查結果','需要一張物料狀態的照片'];
  String buttonText = '上傳物料狀態的照片';

  showTransportDialog(context, title, contents, buttonText, _finishCheck);
 
}
  Widget builder(BuildContext context) {
        return FutureBuilder<bool>(
      future: _getLotStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        
        if(isLoad)
          return WaitingWidget();

        return builder1(context);
      }
    );
  }
  Widget builder1(BuildContext context) {
 
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
                              Data.is_product ? Data.lotStatus.barcode:'物料資訊',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: Data.header_font,
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  //shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  //children: list,
                  child:Column(
                    children:list
                  )
                ),
              ),
              ShowButton(show:Data.lotStatus.status == lot_status.SCHEDULED.value,title:'拿取物料',onPressed:picked),
              ShowButton(show:Data.lotStatus.status == lot_status.PICKED.value,title:'退回物料',onPressed:cancelPicked,background:Colors.red),
              ShowButton(show:canFinish,title:'完成檢查',onPressed:_takePicture),
              ShowButton(show:canCheck,title:'儲存檢查結果',onPressed:saveCheck),
              //ShowButton(show:Data.isCurrent,title:'修改重量',onPressed:updateWeight),
              ShowButton(show:false,title:'修改重量',onPressed:updateWeight),

            ],
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
          title: const Text('',
          style: TextStyle(color:Colors.white),)
        ),
      body:  builder(context)
     
    );
  }
}


