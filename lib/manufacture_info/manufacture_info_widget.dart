import 'package:bro_flutter_app/manufacture_check/manufacture_check_widget.dart';
import 'package:bro_flutter_app/manufacture_info/manufacture_widget.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attachs_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info_header.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/transport_order_items/transport_order_items_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import '../transport_order_info/transport_order_info_model.dart';

class ManufactureInfoWidget extends StatefulWidget {
  ManufactureInfoWidget( {super.key,
  required this.title ,
  required this.info,
  this.hasReturn,
  this.hasAction,
  
  });
  late ManufactureInfo info;
  late String title;
  bool? hasReturn;
  bool? hasAction;
  @override
  State<ManufactureInfoWidget> createState() => _ManufactureInfoWidgetState();
}

class _ManufactureInfoWidgetState extends State<ManufactureInfoWidget>
    with TickerProviderStateMixin {
  late TransportOrderInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String CameraIcon = 'assets/images/camera.svg';
  final String QrCodeIcon = 'assets/images/qr-code.svg';
  
  bool canRequest = false;
  bool canReturn = false;
  bool canSave = true;
  bool canFinish = true;  
  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => TransportOrderInfoModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    )..addListener(() => setState(() {}));

  }
  _startButton(BuildContext context){

  }
_saveButton(BuildContext context){

}
_requestButton(BuildContext context){

}
_finishButton(BuildContext context){

}
_returnButton(BuildContext context){

}
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
                         isScrollable: true,
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
                            text: '再製單資訊',
                          ),
                          Tab(
                            text: '物料清單',
                          ),
                          Tab(
                            text: '附件',
                          ),
                          Tab(
                            text: '檢測項目',
                          ),
                            Tab(
                            text: '成品清單',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {},() async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          ManufactureWidget(info:widget.info,
                        
                          canSave:canSave,
                          canFinish:canFinish,
                          savePressed: ()=>_saveButton(context),
                          finishPressed: ()=>_finishButton(context)),
              
                          TransportOrderItemsWidget(lots:widget.info.lots,
                          lots_meta: widget.info.lots_meta,
                        
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                        
                          finishPressed: ()=>_finishButton(context)),
                        
                          TransportOrderAttachsWidget(attachs:widget.info.attachs,
                          canRequest:canRequest,
                          canReturn:canReturn,
                          canFinish:canFinish,
                          requestPressed: ()=>_requestButton(context),
                          returnPressed: ()=>_returnButton(context),
                          finishPressed: ()=>_finishButton(context),),
                          
                          ManufactureCheckWidget(
                            checkables:widget.info.checkables,
                          canFinish:canFinish,
                          finishPressed: ()=>_finishButton(context),),

                          ManufactureCheckWidget(
                            checkables:widget.info.checkables,
                          canFinish:canFinish,
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
