import 'package:bro_flutter_app/data.dart';

import 'package:flutter_svg/svg.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureProductWidget extends StatefulWidget {
  ManufactureProductWidget({super.key,
  required this.index,
  required this.info,
  });
       
  late int index;
  late Map<String,dynamic> info;
  @override
  State<ManufactureProductWidget> createState() => _ManufactureProductWidgetState();
}

class _ManufactureProductWidgetState extends State<ManufactureProductWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String checkIcon = 'assets/images/check-circle.svg';
  String exclamationIcon = 'assets/images/exclamation-circle.svg';
  
  @override
  void initState() {
    super.initState();

  }
  
  @override
  void dispose() {
    
    super.dispose();
  }
 
 _onPress()async{
  Data.product_index = widget.index;
  await Navigator.pushNamed(context,"/manufacture-product");
  setState(() {
    widget.info['weiget'] = Data.products.list[Data.product_index]['weiget'] ?? '';
   
  });
  
 }
  @override
  Widget build(BuildContext context) {
    String icon = checkIcon;
    Color color = Colors.green;
    var weight = widget.info['weight'] ?? 0;
    var len = widget.info['attachments'] == null ? 0: widget.info['attachments'].length;
    if(weight == 0 || len == 0){
      icon = exclamationIcon;
      color = Color.fromRGBO(0xfa, 0xcc, 0x15, 1);
    }
      return 
InkWell(
  onTap: () {_onPress();}, // Handle your callback
  child: 
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
  child: Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      border: Border.all(
        color: FlutterFlowTheme.of(context).primaryText,
      ),
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    widget.info['barcode'],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.asset(
                    icon,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn,),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              '重量',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              border: Border.all(
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Generated code for this Container Widget...
Expanded(
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(-1, 0),
        child: Text(
          widget.info['weight']??'',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Readex Pro',
                fontSize: 16,
                letterSpacing: 0,
              ),
        ),
      ),
    ),
  ),
),

                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Text(
                    'kg',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
));

  }

}
