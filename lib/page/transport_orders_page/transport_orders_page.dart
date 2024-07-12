// TODO Implement this library.import '/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/page/transport_orders_page/transport_orders_page_model.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order_brief/transport_order_brief_widget.dart';
import 'package:bro_flutter_app/utils/filter.dart';
import 'package:bro_flutter_app/utils/sort_order.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';


class TransportOrdersPage extends StatefulWidget {
  const TransportOrdersPage({super.key});

  @override
  State<TransportOrdersPage> createState() => _TransportOrdersPageState();
}

class _TransportOrdersPageState extends State<TransportOrdersPage> {

  late TransportOrdersPageModel _model;
  final String SearchIcon = 'assets/images/search.svg';
  final String SortIcon = 'assets/images/sort-ascending.svg';
  final String FilterIcon = 'assets/images/filter.svg';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransportOrdersPageModel());
    Data.ordersList = [];
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  Future<bool> _getTransportOrders()async{
    
    final ret = await Service.GetTransportOrders();

   return ret;
}
  @override
  Widget build(BuildContext context) {
        return FutureBuilder<bool>(
      future: _getTransportOrders(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        
        return builder(context);
      }
    );
  }
  
  filterPress(){

  }
  _getFilter(){
    bool ret = false;
    for(var i=0;i<Data.filter.length;i++){
      if(Data.filter[i].value == true){
        ret = true;
        break;
      }
    }

    return ret == false ? Colors.grey : Colors.blue;
  }
  Widget builder(BuildContext context) {

    List<Widget> list = [];
    for(var i=0;i<Data.ordersList.length;i++){
      list.add(TransportOrderBriefWidget(info:Data.ordersList[i]));
    }

    var empty = const Center(child:Text('無資料'));
    if(Data.ordersList.isEmpty){
      list.add(empty);
    }
    
    return 
   Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
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
                      '運輸單',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '搜尋運輸單編號',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon:IconButton(
                            onPressed: (){},
                            icon: SvgPicture.asset(
                            SearchIcon,
                            height: 24,
                            width: 24,
                            ),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    const SortOrder(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: 
                      InkWell(
                        onTap: () async{ 
                        print("Tapped on container");
                        await showTransportFilter(context,filterPress);
                        setState(
                          (){
                            
                          }
                        );
                        },
                        child:Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:SvgPicture.asset(
                        FilterIcon,
                        colorFilter: ColorFilter.mode(_getFilter(), BlendMode.srcIn),),
                      ),
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: list,
                ),
              ),
            ]);
  }
}
