import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:flutter/material.dart';


class FilterWidget extends StatelessWidget {
  
  FilterWidget({this.show = false,
  this.onPressed,filter})
  {
    for(var i=0;i<filter.length;i++){
      this.filter[i].value = filter[i].value;
    }
  }
  bool show = false;
  VoidCallback? onPressed;

  List<ValueNotifier<bool>> filter = [ValueNotifier(false),ValueNotifier(false),
  ValueNotifier(false),ValueNotifier(false),ValueNotifier(false),ValueNotifier(false)];

  filter1Press(){

    filter[0].value = !filter[0].value;

    
  }
  filter2Press(){

    filter[1].value = !filter[1].value;

    
  }

  filter3Press(){

    filter[2].value = !filter[2].value;

    
  }
  filter4Press(){

    filter[3].value = !filter[3].value;

    
  }
  filter5Press(){

    filter[4].value = !filter[4].value;

    
  }
  filter6Press(){

    filter[5].value = !filter[5].value;

    
  }

  var disable_color = Colors.grey;
  var disable_bkColor = Colors.white;

  var enable_bkColor = Color.fromRGBO(219, 234, 254,1);
  var enable_color = Color.fromRGBO(37, 99, 235,1);
  
  Widget _filterBuilder1(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'派車運輸',filter[0].value,filter1Press);                 

  }
  Widget _filterBuilder2(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'開始運輸',filter[1].value,filter2Press);                 

  }
  Widget _filterBuilder3(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'等待回覆',filter[2].value,filter3Press);                 

  }
  Widget _filterBuilder4(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'生產廠簽收',filter[3].value,filter4Press);                 

  }
  Widget _filterBuilder5(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'生產廠拒絕',filter[4].value,filter5Press);                 

  }
  Widget _filterBuilder6(BuildContext context, bool selectedButton, Widget? child) {

    return filterContent(context,'開始回程',filter[5].value,filter6Press);                 

  }

  filterContent(BuildContext context,String text,bool filter,VoidCallback onPressed){
    Color color  = disable_color;
    if(filter == true){
      color = enable_color;
    }

    Color bkColor  = disable_bkColor;
    if(filter == true){
      bkColor = enable_bkColor;
    }

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

  searchPress(BuildContext context)async{
    Data.filter = filter;
    await Service.GetTransportOrders();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    ValueListenableBuilder<bool> filterBuild1 = ValueListenableBuilder<bool>(
        builder: _filterBuilder1,
        valueListenable: filter[0],
      );
    ValueListenableBuilder<bool> filterBuild2 = ValueListenableBuilder<bool>(
        builder: _filterBuilder2,
        valueListenable: filter[1],
      );
    ValueListenableBuilder<bool> filterBuild3 = ValueListenableBuilder<bool>(
        builder: _filterBuilder3,
        valueListenable: filter[2],
      );
    ValueListenableBuilder<bool> filterBuild4 = ValueListenableBuilder<bool>(
        builder: _filterBuilder4,
        valueListenable: filter[3],
      );
    ValueListenableBuilder<bool> filterBuild5 = ValueListenableBuilder<bool>(
        builder: _filterBuilder5,
        valueListenable: filter[4],
      );
    ValueListenableBuilder<bool> filterBuild6 = ValueListenableBuilder<bool>(
        builder: _filterBuilder6,
        valueListenable: filter[5],
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
                    searchPress(context);
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