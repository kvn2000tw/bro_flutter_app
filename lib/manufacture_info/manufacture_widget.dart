import 'package:bro_flutter_app/manufacture_info/manufacture_detail_widget.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/show_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureWidget extends StatefulWidget {
  ManufactureWidget({super.key,
  required this.info,

  this.canFinish = false,
  
  this.finishPressed,

  });

  late ManufactureInfo info;
  
  late bool canFinish;  
  
  final VoidCallback? finishPressed; 
 
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
ManufactureDetailWidget(info:widget.info,canFinish:widget.canFinish,onPressed:widget.finishPressed);

  }
}
