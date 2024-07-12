import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class FilterWidget extends StatelessWidget {
  
  FilterWidget({this.show = false,
  this.onPressed,})
  {
    
  }
  bool show = false;
  VoidCallback? onPressed;

  filter1Press(){

    Data.filter[0].value = !Data.filter[0].value;

    
  }
  filter2Press(){

    Data.filter[1].value = !Data.filter[1].value;

    
  }

  filter3Press(){

    Data.filter[2].value = !Data.filter[2].value;

    
  }
  filter4Press(){

    Data.filter[3].value = !Data.filter[3].value;

    
  }
  filter5Press(){

    Data.filter[4].value = !Data.filter[4].value;

    
  }
  filter6Press(){

    Data.filter[5].value = !Data.filter[5].value;

    
  }

  var disable_color = Colors.grey;
  var disable_bkColor = Colors.white;

  var enable_bkColor = Color.fromRGBO(219, 234, 254,1);
  var enable_color = Color.fromRGBO(37, 99, 235,1);
  
  Widget _filterBuilder1(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'派車運輸',Data.filter[0].value == true ? enable_color : disable_color,Data.filter[0].value == true ? enable_bkColor : disable_bkColor,filter1Press);                 

  }
  Widget _filterBuilder2(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'開始運輸',Data.filter[1].value == true ? enable_color : disable_color,Data.filter[1].value == true ? enable_bkColor : disable_bkColor,filter2Press);                 

  }
  Widget _filterBuilder3(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'等待回覆',Data.filter[2].value == true ? enable_color : disable_color,Data.filter[2].value == true ? enable_bkColor : disable_bkColor,filter3Press);                 

  }
  Widget _filterBuilder4(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'生產廠簽收',Data.filter[3].value == true ? enable_color : disable_color,Data.filter[3].value == true ? enable_bkColor : disable_bkColor,filter4Press);                 

  }
  Widget _filterBuilder5(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'生產廠拒絕',Data.filter[4].value == true ? enable_color : disable_color,Data.filter[4].value == true ? enable_bkColor : disable_bkColor,filter5Press);                 

  }
  Widget _filterBuilder6(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'開始回程',Data.filter[5].value == true ? enable_color : disable_color,Data.filter[5].value == true ? enable_bkColor : disable_bkColor,filter6Press);                 

  }

  filterContent(BuildContext context,String text,Color color,Color bkColor,VoidCallback onPressed){
    return                    Container(
                              width: 110,
                              decoration: BoxDecoration(),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                  onPressed();
                                },
                                text: text,
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: bkColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: color,
                                        letterSpacing: 0,
                                      ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
  }
  @override
  Widget build(BuildContext context) {
    ValueListenableBuilder<bool> filterBuild1 = ValueListenableBuilder<bool>(
        builder: _filterBuilder1,
        valueListenable: Data.filter[0],
      );
    ValueListenableBuilder<bool> filterBuild2 = ValueListenableBuilder<bool>(
        builder: _filterBuilder2,
        valueListenable: Data.filter[1],
      );
    ValueListenableBuilder<bool> filterBuild3 = ValueListenableBuilder<bool>(
        builder: _filterBuilder3,
        valueListenable: Data.filter[2],
      );
    ValueListenableBuilder<bool> filterBuild4 = ValueListenableBuilder<bool>(
        builder: _filterBuilder4,
        valueListenable: Data.filter[3],
      );
    ValueListenableBuilder<bool> filterBuild5 = ValueListenableBuilder<bool>(
        builder: _filterBuilder5,
        valueListenable: Data.filter[4],
      );
    ValueListenableBuilder<bool> filterBuild6 = ValueListenableBuilder<bool>(
        builder: _filterBuilder6,
        valueListenable: Data.filter[5],
      );

    return 
    // Generated code for this Container Widget...
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
  child: Container(
    width: double.infinity,
    height: 350,
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
            alignment: AlignmentDirectional(-1, 0),
            child: Text(
              '篩選項目',
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
          height: 180,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Text(
                  '狀態',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            filterBuild1,
                            filterBuild2,
                            filterBuild3,
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            filterBuild4,
                            filterBuild5,
                            filterBuild6,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(0, 1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: '搜尋',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
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
          ),
        ),
      ],
    ),
  ),
);

   
  }
}