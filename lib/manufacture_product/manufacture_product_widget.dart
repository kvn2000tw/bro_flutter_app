import 'package:bro_flutter_app/manufacture_check/manufacture_check_item_widget.dart';
import 'package:bro_flutter_app/utils/show_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureProductWidget extends StatefulWidget {
  ManufactureProductWidget({super.key,
  required this.products,

  this.canFinish = false,

  this.finishPressed,

  });

  late List<dynamic> products;
  late bool canFinish;  
  
  final VoidCallback? finishPressed; 
   
  @override
  State<ManufactureProductWidget> createState() => _ManufactureProductWidgetState();
}

class _ManufactureProductWidgetState extends State<ManufactureProductWidget> {

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
  /*
  for(var i=0;i<widget.checkables.length;i++){
    list.add(ManufactureCheckItemWidget(checkable:widget.checkables[i]));
  }
*/
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
   
   
  ],
);


  }
}
