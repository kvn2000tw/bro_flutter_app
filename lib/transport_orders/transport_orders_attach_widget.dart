import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'transport_orders_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransportOrdersAttachWidget extends StatefulWidget {
  TransportOrdersAttachWidget({super.key,
  required this.attach,
  });

  late Map<String,dynamic> attach;
  @override
  State<TransportOrdersAttachWidget> createState() => _TransportOrdersAttachtState();
}

class _TransportOrdersAttachtState extends State<TransportOrdersAttachWidget> {
  
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

    String url =  widget.attach["source"]["signedUrl"];

    return Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  child: Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(-1, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
);

        
  }
}
