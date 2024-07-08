import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:flutter/material.dart';


class ReturnButton extends StatelessWidget {
  
  ReturnButton({this.show = false,
  this.onPressed,})
  {
    
  }
  bool show = false;
  VoidCallback? onPressed;
  Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('開始回程？'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('確認'),
            onPressed: () async{
              onPressed!();
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
    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
    child: FFButtonWidget(
      onPressed: () async{
        print('Button pressed ...');
        _showMyDialog(context);
      },
      text: '開始回程',
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