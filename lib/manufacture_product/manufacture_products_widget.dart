import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/manufacture_product/manufacture_product_widget.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/utils/show_button.dart';
import 'package:bro_flutter_app/utils/waiting_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureProductsWidget extends StatefulWidget {
  ManufactureProductsWidget({super.key,

  this.canFinish = false,
  
  this.finishPressed,

  });

  late List<dynamic> checkables;
  late bool canFinish;  
    
  final VoidCallback? finishPressed; 
   
  @override
  State<ManufactureProductsWidget> createState() => _ManufactureProductsWidgetState();
}

class _ManufactureProductsWidgetState extends State<ManufactureProductsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoad = true;
  bool canSave = false;
  @override
  void initState() {
    super.initState();
    isLoad = true;
  
  }
  _save(){

  }
  @override
  void dispose() {
   
    super.dispose();
  }
 Future<bool> _getManufactureProducts()async{
  bool ret = await Service.manufacturerProducts();

  isLoad = false;

  return ret;
 }
 
  @override
  Widget build(BuildContext context) {
        return FutureBuilder<bool>(
      future: _getManufactureProducts(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        
        if(isLoad)
          return WaitingWidget();

        return builder(context);
      }
    );
  }
  
  Widget builder(BuildContext context) {
  List<Widget> list = [];
  
  for(var i=0;i<Data.products.list.length;i++){
    list.add(ManufactureProductWidget(index:i,info:Data.products.list[i]));
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
          '成品清單 總重量:${Data.products.meta['total_weight']} kg 總數量:${Data.products.meta['total_item']} ',
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
