import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order/transport_order_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info_header.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attachs_widget.dart';
import 'package:bro_flutter_app/transport_order_items/transport_order_items_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:overlay_support/overlay_support.dart';

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


  }

  @override
  void dispose() {
    _model.dispose();

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
  void showNotification(String title,String body)
{
  showSimpleNotification(
    Text(title,textAlign: TextAlign.center,
      style: TextStyle(
      color: Colors.black,
    ),),
    subtitle: Text(body,textAlign: TextAlign.center,
      style: TextStyle(
      color: Colors.black,
    ),),
    background: Colors.cyan.shade700,
    foreground:Colors.cyan.shade700,
    duration: Duration(seconds: 2),
  );     
}
Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('開始運輸？'),
        content:  const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('將紀錄起始里程數並開始運輸'),
              Text('需要一張開始里程數的照片'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('上傳開始里程數照片'),
            onPressed: () async {
              
              Data.runFunc = 'started';
              await Navigator.pushNamed(context,'/camera');
              if(Data.httpRet == true){
                showNotification('開始運輸', '完成');
              }
              if (context.mounted){
                Navigator.pop(context);
              }
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
  _startButton(BuildContext context)async{
    await _showMyDialog(context);
    
    setState(
      (){
        widget.info = Data.transport_info;
        initButton();
      }
    );

  }

  Future<void> _showRequestDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('申請結算？'),
        content:  const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('確認送出運輸單物料結算申請？'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('確認'),
            onPressed: () async{
             
              await Service.Request();
              if (context.mounted){
                Navigator.of(context).pop();
              }

              if(Data.httpRet == true){
                showNotification('結算','完成');
              }
             
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
  Future<void> _showReturnDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('開始回程？'),
        content:  const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('確認'),
            onPressed: () async{
             
              await Service.Returned();
              if(context.mounted){
                Navigator.of(context).pop();
              }
              if(Data.httpRet == true){
                showNotification('開始回程','完成');
              }
             
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
  Future<void> _showFinishDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('結束運輸？'),
        content:  const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('將紀錄里程數並結束運輸'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('上傳結束里程數照片'),
            onPressed: () async{
             Data.runFunc = 'finished';
            
              await Navigator.pushNamed(context,'/camera');

              if (context.mounted){
                Navigator.of(context).pop();
              }
              if(Data.httpRet == true){
                showNotification('結束運輸','完成');
              }
             
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
  Future<void> _showRequestAlert(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('無法結算'),
        content:  const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('請確認所有貨品檢查結果'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('確認'),
            onPressed: () async{
              Navigator.of(context).pop();
             
            },
          ),
         
        ],
      );
    },
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
  _requestButton(BuildContext context)async{

    var ret = await checkRequest();
    if(ret == false){
      if(context.mounted){
      _showRequestAlert(context);
      }
      return;
    }
    if(context.mounted){
      await _showRequestDialog(context);
    }
    setState(
      (){
        widget.info = Data.transport_info;
        initButton();
      }
    );

  }

  _returnButton(BuildContext context)async{

    await _showReturnDialog(context);
    setState(
      (){
        widget.info = Data.transport_info;
        initButton();
      }
    );

  }
  _finishButton(BuildContext context)async{

    await _showFinishDialog(context);
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
                          TransportOrderWidget(info:widget.info,canStart:canStart,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          startPressed: ()=>_startButton(context),
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context)),
                          TransportOrderItemsWidget(info:widget.info,
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
