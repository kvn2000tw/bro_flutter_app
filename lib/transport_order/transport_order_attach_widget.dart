import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class TransportOrderAttachWidget extends StatefulWidget {
  TransportOrderAttachWidget({super.key,
  required this.attach,
  });

  late Map<String,dynamic> attach;
  @override
  State<TransportOrderAttachWidget> createState() => _TransportOrderAttachtState();
}

class _TransportOrderAttachtState extends State<TransportOrderAttachWidget> {
  
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
    width: 100,//double.infinity,
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
