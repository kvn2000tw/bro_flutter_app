import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:flutter/material.dart';


class StartButton extends StatelessWidget {
  
  StartButton({this.show = false})
  {
    
  }
  
  bool show = false;
Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('開始運輸？'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('將紀錄起始里程數並開始運輸'),
              Text('需要一張開始里程數的照片'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('上傳開始里程數照片'),
            onPressed: () async{
              
              Data.runFunc = 'started';
              await Navigator.pushNamed(context,'/camera');

              Navigator.of(context).pop();
            },
          ),
           TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
 return show == false ? Container():Align(
  alignment: AlignmentDirectional(0, 0),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
    child: FFButtonWidget(
      onPressed: () async{
        print('Button pressed ...');
        await _showMyDialog(context);
    
      },
      text: '開始運輸',
      options: FFButtonOptions(
        width: double.infinity,
        height: 40,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).primaryBackground,
              letterSpacing: 0,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
  }
}