import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attach_widget.dart';
import 'package:bro_flutter_app/utils/show_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class TransportOrderAttachsWidget extends StatefulWidget {
  TransportOrderAttachsWidget({super.key,
  required this.attachs,
  this.canRequest=false ,
  this.canReturn=false ,
  this.canFinish=false ,  
  this.requestPressed,
  this.returnPressed,
  this.finishPressed  
  });

  late List<dynamic> attachs;
  late bool canRequest;
  late bool canReturn;
  late bool canFinish;  
  final VoidCallback? requestPressed;
  final VoidCallback? returnPressed;  
  final VoidCallback? finishPressed;    
  @override
  State<TransportOrderAttachsWidget> createState() => _TransportOrderAttachsState();
}

class _TransportOrderAttachsState extends State<TransportOrderAttachsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    List<Widget> list = [];
    for(var i = 0; i < widget.attachs.length; i++){
        list.add(TransportOrderAttachWidget(attach:widget.attachs[i]));
    }

    return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '附件',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: Data.title_font,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),  
              ),
                            list.length == 0 ? Expanded(child:Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),

  child: Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Text(
        '無附件檔案',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: Data.title_font,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
      ),
    ),
  ),
)):
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: list,
                ),
              ),
              
              ShowButton(show:widget.canRequest,title:'結算',onPressed:widget.requestPressed),
              ShowButton(show:widget.canReturn,title:'開始回程',onPressed:widget.returnPressed),
              ShowButton(show:widget.canFinish,title:Data.is_product?'完成再製':'結束運輸',onPressed:widget.finishPressed),
            ],
          );
  }
}
