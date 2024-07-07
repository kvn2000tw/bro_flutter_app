import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_attachs_widget.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_list_widget.dart';
import 'package:bro_flutter_app/transport_orders/transport_orders_widget.dart';
import 'package:bro_flutter_app/transport_orders_detail/transport_orders_detail_list_widget.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_header.dart';

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

    if(widget.info.status == transport_status.DISPATCHED.value){
      canStart = true;
    }

    if(widget.info.status == transport_status.STARTED.value || 
      widget.info.status == transport_status.REJECTED.value){
      canRequest = true;
    }

    if(widget.info.status == transport_status.APPROVED.value) 
    {
      canReturn = true;
    }
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
                          TransportOrdersWidget(info:widget.info,canStart:canStart,canRequest:canRequest,canReturn:canReturn),
                          TransportOrdersDetailListWidget(info:widget.info,canStart:canStart,canRequest:canRequest,canReturn:canReturn,),
                          TransportOrdersAttachsWidget(attachs:widget.info.attachs,canStart:canStart,canRequest:canRequest,canReturn:canReturn),
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
