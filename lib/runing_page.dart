
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/home_page.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_widget.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class RuningPage extends StatefulWidget {
   RuningPage({super.key,
  
  required this.onTap});

  late GestureTapCallback onTap;

  @override
  State<RuningPage> createState() => _Page1WidgetState();
}

class _Page1WidgetState extends State<RuningPage>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {

    super.dispose();
  }

  _goTransportListPage(){
    widget.onTap();

  }
  Widget _empty(BuildContext context) {
    return Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 400,
              height: 160,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SvgPicture.asset(
                        'assets/images/exclamation-circle.svg',
                        width: 300,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        '目前尚未有執行中運輸單',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        '請至運輸單列表選擇並執行運輸單',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ),
                  Padding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
  child: Container(
    width: 150,
    height: 30,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
        _goTransportListPage();

      },
      text: '運輸單列表',
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
),

                ],
              ),
            ));
  }
  @override
  Widget build(BuildContext context) {
    
    if(Data.current.id == '')
      return _empty(context);
    
    return TransportOrdersInfoWidget(
      title:'執行中的運輸單',hasAction:true,
      info:Data.current

    );
   
  }
}
