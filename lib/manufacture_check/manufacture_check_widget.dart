import 'package:bro_flutter_app/manufacture_check/manufacture_check_item_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/show_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureCheckWidget extends StatefulWidget {
  ManufactureCheckWidget({super.key,
  required this.checkables,

  this.canFinish = false,

  this.finishPressed,

  });

  late List<dynamic> checkables;
  late bool canFinish;  
  
  final VoidCallback? finishPressed; 
   
  @override
  State<ManufactureCheckWidget> createState() => _ManufactureCheckWidgetState();
}

class _ManufactureCheckWidgetState extends State<ManufactureCheckWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool canSave = false;

  @override
  void initState() {
    super.initState();
  
  }

  @override
  void dispose() {
   
    super.dispose();
  }
  _save(){

  }
  @override
  Widget build(BuildContext context) {
  List<Widget> list = [];
  
  for(var i=0;i<widget.checkables.length;i++){
    list.add(ManufactureCheckItemWidget(checkable:widget.checkables[i]));
  }

    // Generated code for this Container Widget...
return // Generated code for this Container Widget...
// Generated code for this Column Widget...
Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    // Generated code for this Container Widget...
Align(
  alignment: AlignmentDirectional(-1, 0),
  child: Padding(
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
          '檢查項目',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Readex Pro',
                fontSize: 20,
                letterSpacing: 0,
              ),
        ),
      ),
    ),
  ),
),
    Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
         
          child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: list,
        )),
        ),
      ),
    ShowButton(show:widget.canFinish,title:'完成再製',onPressed:widget.finishPressed),
    ShowButton(show:canSave,title:'儲存檢查結果',onPressed:_save),
   
  ],
);


  }
}
