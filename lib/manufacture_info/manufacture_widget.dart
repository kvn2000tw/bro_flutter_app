import 'package:bro_flutter_app/manufacture_info/manufacture_detail_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/show_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class ManufactureWidget extends StatefulWidget {
  ManufactureWidget({super.key,
  required this.info,

  this.canFinish = false,
  this.canSave = false,
  this.finishPressed,
  this.savePressed,  
  });

  late ManufactureInfo info;
  
  late bool canSave;
  late bool canFinish;  
  
  final VoidCallback? finishPressed; 
  final VoidCallback? savePressed;    
  @override
  State<ManufactureWidget> createState() => _ManufactureWidgetState();
}

class _ManufactureWidgetState extends State<ManufactureWidget> {

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

    // Generated code for this Container Widget...
return // Generated code for this Container Widget...
// Generated code for this Column Widget...
Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: ManufactureDetailWidget(info:widget.info)
          ),
        ),
      ),
    ShowButton(show:widget.canFinish,title:'完成再製',onPressed:widget.finishPressed),
    ShowButton(show:widget.canSave,title:'儲存資料',onPressed:widget.savePressed),
   
  ],
);


  }
}
