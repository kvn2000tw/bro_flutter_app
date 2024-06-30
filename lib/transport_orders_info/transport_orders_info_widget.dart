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
  this.hasAction,
  
  });
  late TransportOrdersInfo info;
  late String title;
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

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => TransportOrdersInfoModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
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
             TransportOrdersInfoHeader(title:widget.title,hasAction:widget.hasAction),
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
                          TransportOrdersWidget(info:widget.info),
                          TransportOrdersDetailListWidget(info:widget.info),
                          TransportOrdersAttachsWidget(attachs:widget.info.attachs),
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
