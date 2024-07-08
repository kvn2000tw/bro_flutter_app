import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_attachs_widget.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_list_widget.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_widget.dart';
import 'package:bro_flutter_app/transport_orders_detail/transport_orders_detail_list_widget.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_header.dart';
import 'package:overlay_support/overlay_support.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'transport_orders_info_model.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TransportOrdersInfoWidget extends StatefulWidget {
  TransportOrdersInfoWidget( {super.key,
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
  State<TransportOrdersInfoWidget> createState() => _TransportOrdersInfoWidgetState();
}

class _TransportOrdersInfoWidgetState extends State<TransportOrdersInfoWidget>
    with TickerProviderStateMixin {
  late TransportOrdersInfoModel _model;

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

    _model = createModel(context, () => TransportOrdersInfoModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));

    Data.transport_id = widget.info.id;

    print('widget.info.status ${widget.info.status}');
    if(widget.info.status == transport_status.DISPATCHED.value){
      if(Data.current.id == '')
        canStart = true;
    }

    else if(widget.info.status == transport_status.STARTED.value || 
      widget.info.status == transport_status.REJECTED.value){
      canRequest = true;
    }

    else if(widget.info.status == transport_status.APPROVED.value) 
    {
      canReturn = true;
    }
    else if(widget.info.status == transport_status.RETURNED.value) 
    {
      canFinish = true;
    }

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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

  Future<void> _showRequestDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('申請結算？'),
        content:  SingleChildScrollView(
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
             
              bool ret = await Service.Request();
              Navigator.of(context).pop();
              if(ret == true){
                showNotification('上傳','成功');
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
        content:  SingleChildScrollView(
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
             
              bool ret = await Service.Returned();
              Navigator.pop(context);
              if(ret == true){
                showNotification('上傳','成功');
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
        content:  SingleChildScrollView(
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

              Navigator.of(context).pop();
             
              //showNotification('上傳','成功');
              
             
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
        content:  SingleChildScrollView(
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
      _showRequestAlert(context);
      return;
    }
    await _showRequestDialog(context);
    setState(
      (){
      
      }
    );

  }

  _returnButton(BuildContext context)async{

    await _showReturnDialog(context);
    setState(
      (){
      
      }
    );

  }
  _finishButton(BuildContext context)async{

    await _showFinishDialog(context);
    Navigator.pushNamed(context,'/home');

  }

  @override
  Widget build(BuildContext context) {
    return 
        Column(
            mainAxisSize: MainAxisSize.max,
            children: [
             TransportOrdersInfoHeader(title:widget.title,hasReturn:widget.hasReturn,hasAction:widget.hasAction),
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
                        padding: EdgeInsets.all(4),
                        tabs: [
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
                          TransportOrdersWidget(info:widget.info,canStart:canStart,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context)),
                          TransportOrdersDetailListWidget(info:widget.info,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context)),
                          TransportOrdersAttachsWidget(attachs:widget.info.attachs,
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
