import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order/transport_order_model.dart';
import 'package:bro_flutter_app/transport_order/transport_order_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info_header.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attachs_widget.dart';
import 'package:bro_flutter_app/transport_order_items/transport_order_items_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/dialog.dart';
import 'package:bro_flutter_app/utils/notify.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'transport_order_info_model.dart';

class TransportOrderInfoWidget extends StatefulWidget {
  TransportOrderInfoWidget( {super.key,
  required this.title ,
  required this.info,
  this.hasReturn,
  this.hasAction,
  
  });
  late TransportOrdersInfo info;
  late String title;
  bool? hasReturn;
  bool? hasAction;
  @override
  State<TransportOrderInfoWidget> createState() => _TransportOrderInfoWidgetState();
}

class _TransportOrderInfoWidgetState extends State<TransportOrderInfoWidget>
    with TickerProviderStateMixin {
  late TransportOrderInfoModel _model;
  late TransportOrderModel _transportOrderModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String CameraIcon = 'assets/images/camera.svg';
  final String QrCodeIcon = 'assets/images/qr-code.svg';
  bool canStart = false;
  bool canRequest = false;
  bool canReturn = false;
  bool canFinish = false;  
  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => TransportOrderInfoModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));

    initButton();
    _transportOrderModel = createModel(context, () => TransportOrderModel());

    _transportOrderModel.textController1 ??= TextEditingController(text:widget.info.initial_odometer.toString());
    _transportOrderModel.textFieldFocusNode1 ??= FocusNode();

    _transportOrderModel.textController2 ??= TextEditingController( text:widget.info.final_odometer.toString());
    _transportOrderModel.textFieldFocusNode2 ??= FocusNode();

    _transportOrderModel.textController3 ??= TextEditingController(text:widget.info.note);
    _transportOrderModel.textFieldFocusNode3 ??= FocusNode();

    _transportOrderModel.textController4 ??= TextEditingController(text:widget.info.gmap.toString());
    _transportOrderModel.textFieldFocusNode4 ??= FocusNode();

  }

  @override
  void dispose() {
    _model.dispose();
    _transportOrderModel.dispose();

    super.dispose();
  }

  initButton(){
    Data.transport_id = widget.info.id;

    canStart = false;
    canRequest = false;
    canReturn = false;
    canFinish = false;  

    print('widget.info.status ${widget.info.status}');
    if(widget.info.status == transport_status.DISPATCHED.value){
      if(Data.current.id == ''){
        canStart = true;
      }
    }

    else if(widget.info.status == transport_status.STARTED.value || 
      widget.info.status == transport_status.REJECTED.value){
      if(Data.isCurrent == true){
        canRequest = true;
      }
    }

    else if(widget.info.status == transport_status.APPROVED.value) 
    {
      if(Data.isCurrent == true){
        canReturn = true;
      }
    }
    else if(widget.info.status == transport_status.RETURNED.value) 
    {
      if(Data.isCurrent == true){
        canFinish = true;
      }
    }
  }

  _startOnPress()async{
    Data.runFunc = 'started';
    if(widget.info.isgmap == 0){
      Data.tmp_value = _transportOrderModel.textController1.text;
      Data.tmp_note = _transportOrderModel.textController3.text;
    }else {
      Data.tmp_value = '';
      Data.tmp_note = '';
    }
    await Navigator.pushNamed(context,'/camera');

    if (context.mounted){
      Navigator.pop(context);
    }

    if(Data.httpRet == true){
        showNotification('開始運輸', '完成');
        
    }else {
      showAlert(context, '錯誤', Data.errorMessage);
      
    }

    FocusManager.instance.primaryFocus?.unfocus();

  }
  _startButton(BuildContext context)async{

    var start = double.parse(_transportOrderModel.textController1.text);

    if(widget.info.isgmap == 0 && start == 0){
      showAlert(context, '錯誤', "請輸入起始里程數");
      return;
    }
    String title = '開始運輸?';
    List<String> list = ['將紀錄起始里程數並開始運輸',
    '起始里程數','要一張開始里程數的照片'];
    String buttonText = '上傳開始里程數照片';
 
    await showTransportDialog(context,title,list,buttonText,_startOnPress);
    
    setState(
      (){
        widget.info = Data.transport_info;
        initButton();
      }
    );

  }

Future<bool> checkRequest()async{
  if(Data.current.id == '')    return false;

  Data.transport_id = Data.current.id;
  
  for(var i=0;i<Data.current.lots.length;i++){
    if(Data.current.lots[i]['status'] == lot_status.DISPATCHED.value)    return false;
  }
  return true;
}
requestPress()async{
  
  await Service.Request();
  if (context.mounted){
    Navigator.of(context).pop();
  }

  if(Data.httpRet == true){
    showNotification('結算','完成');
  }
}
returnPress()async{
  
  await Service.Returned();
  if(context.mounted){
    Navigator.of(context).pop();
  }
  if(Data.httpRet == true){
    showNotification('開始回程','完成');
  }
}
finishPress()async{
  
    Data.runFunc = 'finished';
            
    await Navigator.pushNamed(context,'/camera');

    if (context.mounted){
      Navigator.of(context).pop();
    }
    if(Data.httpRet == true){
      showNotification('結束運輸','完成');
    }
             
}

  _requestButton(BuildContext context)async{

    var ret = await checkRequest();
    if(ret == false){
      if(context.mounted){
        showAlert(context,'無法結算','請確認所有貨品檢查結果');
      }
      return;
    }
   
    String title = '申請結算？';
    List<String> contents = ['確認送出運輸單物料結算申請？'];
    String buttonText = '確認';
    await showTransportDialog(context,title,contents,buttonText,requestPress);
    setState(
      (){
        widget.info = Data.transport_info;
        initButton();
      }
    );

  }

  _returnButton(BuildContext context)async{

    String title = '開始回程？';
    List<String> contents = [''];
    String buttonText = '確認';
    await showTransportDialog(context,title,contents,buttonText,returnPress);
    setState(
      (){
        widget.info = Data.transport_info;
        initButton();
      }
    );

  }
  _finishButton(BuildContext context)async{

    if(widget.info.final_odometer == 0){
      showAlert(context,'結束里程','請填寫並儲存結束里程數');
      return;
    }
    String title = '結束運輸？';
    List<String> contents = ['將紀錄里程數並結束運輸'];
    String buttonText = '上傳結束里程數照片';
    await showTransportDialog(context,title,contents,buttonText,finishPress);
    
    if(context.mounted){
      await Navigator.pushNamed(context,'/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
        Column(
            mainAxisSize: MainAxisSize.max,
            children: [
             TransportOrderInfoHeader(title:widget.title,hasReturn:widget.hasReturn,hasAction:widget.hasAction),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: TabBar(
                        labelColor: FlutterFlowTheme.of(context).primaryText,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        unselectedLabelStyle: TextStyle(),
                        indicatorColor: FlutterFlowTheme.of(context).primary,
                        padding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(
                            text: '運輸單資訊',
                          ),
                          Tab(
                            text: '運輸單貨品',
                          ),
                          Tab(
                            text: '附件',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          TransportOrderWidget(info:widget.info,
                          model:_transportOrderModel,
                          canStart:canStart,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          startPressed: ()=>_startButton(context),
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context)),
                          TransportOrderItemsWidget(lots:widget.info.lots,
                          lots_meta: widget.info.lots_meta,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context)),
                          TransportOrderAttachsWidget(attachs:widget.info.attachs,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
