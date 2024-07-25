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
    _model.textController ??= TextEditingController();
    
    Data.resetPage();
    
    _retrieveData();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return builder(context);

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
  showTitle(){
    String text = '物料單列表';
    if(Data.is_driver){
      text = '運輸單';

    }else if(Data.is_product){
      text = '再製單列表';
    }

    return text;
  }
  showSearch(){
    String text =  '搜尋物料編號';

    if(Data.is_driver){
      text = '搜尋運輸單編號';

    }else if(Data.is_product){
      text = '搜尋再製單編號';
    }

    return text;
  }
  Widget builder(BuildContext context) {

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
                      showTitle(),
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
                            labelText: showSearch(),
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
                            onPressed: ()async{
                              Data.resetPage();
                              await Service.GetTransportOrders();
                              setState(() {
                                
                              });
                            },
                            icon: SvgPicture.asset(
                            SearchIcon,
                            height: 24,
                            width: 24,
                            ),
                            ),
         suffixIcon: _model.textController!.text.isNotEmpty
            ? InkWell(
                onTap: () async {
                  _model.textController?.clear();
                  setState(() {});
                },
                child: Icon(
                  Icons.clear,
                  size: 20,
                ),
              )
            : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                          validator: _model.textControllerValidator
                              .asValidator(context),
                          onEditingComplete: () async{
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                            print('onEditingComplete ${_model.textController.text}');
                            Data.search = _model.textController.text;
                            FocusScope.of(context).unfocus();
                            Data.resetPage();
                            await Service.GetTransportOrders();
                            setState(() {
                              
                            });
                          },  
                        ),
                      ),
                    ),
                    const SortOrder(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
                child: listBuild(context),
              ),
            ]);
  }

   Widget listBuild(BuildContext context) {
    return ListView.separated(
      itemCount: Data.ordersList.length,
      itemBuilder: (context, index) {
        //如果到了表尾
        if ( Data.ordersList.isEmpty || (index > 0 && index == (Data.ordersList.length-1))) {
          //不足100条，继续获取数据
          if (Data.read_more == true) {
            //获取数据
            _retrieveData();
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            );
          } else {
            //已经加载了100条数据，不再获取数据。
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        }
        //显示单词列表项
        return TransportOrderBriefWidget(info:Data.ordersList[index]);
      },
      separatorBuilder: (context, index) => Divider(height: .0),
    );
  }

    void _retrieveData() {
      
    Service.GetTransportOrders().then((e) {
      setState(() {
        //重新构建列表
        Data.page = Data.page+1;
       
      });
    });
  }
}
