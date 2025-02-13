import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class ShowSaveButton extends StatelessWidget {
  
  ShowSaveButton({this.show = false,
  this.title = '',
  this.onPressed,})
  {
    
  }
  String title = '';
  bool show = false;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
   return show == false ? Container():Align(
  alignment: AlignmentDirectional(0, 0),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
    child: FFButtonWidget(
      onPressed: () async{
        print('Button pressed $title');
         onPressed!();
       
      },
      text: title,
       options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
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