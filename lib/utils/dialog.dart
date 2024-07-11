import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:flutter/material.dart';

Future<void> showTransportDialog(BuildContext context,
  String title,List<String> contents,String buttonText,
  VoidCallback onPressed
) async {

  List<Widget> list = [];
  for(var i=0;i<contents.length;i++){

      list.add(Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    contents[i],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ));
  }
  return showDialog<void>(
    context: context,
    //barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        alignment: AlignmentDirectional(0, 1),
 shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16.0)), //this right here
          child: 
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
    child: Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        shape: BoxShape.rectangle,
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
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 21,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: list
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: FFButtonWidget(
                onPressed: () async{
                  print('Button pressed ...');
                  onPressed();

                },
                text: buttonText,
                options: FFButtonOptions(
                  height: 40,
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        letterSpacing: 0,
                      ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                  Navigator.of(context).pop();
                },
                text: '取消',
                options: FFButtonOptions(
                  height: 40,
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0,
                      ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
      );
    },
  );
}
