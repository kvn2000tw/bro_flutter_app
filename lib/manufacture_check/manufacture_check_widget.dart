import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/manufacture_check/manufacture_check_item_widget.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:bro_flutter_app/utils/show_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureCheckWidget extends StatefulWidget {
  ManufactureCheckWidget({super.key,
  required this.checkables,
  required this.id,

  this.canFinish = false,

  this.finishPressed,

  });

  late String id;
  late List<dynamic> checkables;
  late bool canFinish;  
  
  final VoidCallback? finishPressed; 
   
  @override
  State<ManufactureCheckWidget> createState() => _ManufactureCheckWidgetState();
}

class _ManufactureCheckWidgetState extends State<ManufactureCheckWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool canSave = true;

  List<Widget> list = [];
  List<TextEditingController> list_note = [];
  List<ValueNotifier<int>> list_check = [];
  List<ValueNotifier<String>> list_datetime = [];
  
  @override
  void initState() {
    super.initState();
  
    for(var i=0;i<widget.checkables.length;i++){
    list_note.add(TextEditingController(text:widget.checkables[i]['note']??''));
    list_check.add(ValueNotifier(0));
    list_datetime.add(ValueNotifier(''));
    list.add(ManufactureCheckItemWidget(checkable:widget.checkables[i],
    datetimeSelect:list_datetime[i],
    checkSelect:list_check[i],
    note:list_note[i],
    ));
  }

  }

  @override
  void dispose() {
   
    super.dispose();
  }
  _save()async{
    List<dynamic> list = [];
    for(var i=0;i<widget.checkables.length;i++){
      if(list_check[i].value == 0){
        showAlert(context, '錯誤', '請點選狀態');
        return;
      }
    }

    for(var i=0;i<widget.checkables.length;i++){
  
      Map<String,dynamic>  map = {
        "id":widget.checkables[i]['id'],
        "name":widget.checkables[i]['name'],
        "value":list_check[i].value == 1 ? true:false,
        "check_station":widget.checkables[i]['metadata']['check_station'],
        'note':list_note[i].text ,
        //"note":'111' ,
        'recorded_at':list_datetime[i].value
      //"recorded_at":"2024-07-23T04:17:00.000Z"
      };
    
      list.add(map);
    }

    await Service.updateManufactureCheckable(widget.id,list);

    if(Data.httpRet){
      showNotification('儲存檢測項目','完成');
    }
  }
  @override
  Widget build(BuildContext context) {

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
                fontSize: Data.header_font,
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
