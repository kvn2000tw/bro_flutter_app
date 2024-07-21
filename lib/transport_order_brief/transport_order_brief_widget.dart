// TODO Implement this library.import '/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_order_brief/transport_order_brief_one.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:bro_flutter_app/utils/show_order_status.dart';

import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class TransportOrderBriefWidget extends StatefulWidget {
   TransportOrderBriefWidget({super.key,
  required this.info});

  late TransportOrdersInfo info;

  @override
  State<TransportOrderBriefWidget> createState() => _TransportOrderBriefWidgetState();
}

class _TransportOrderBriefWidgetState extends State<TransportOrderBriefWidget> {

  final String ViewIcon = 'assets/images/view-list.svg';
  final String OfficeIcon = 'assets/images/office-building.svg';
  final String LocationIcon = 'assets/images/location-marker.svg';
  final String CalculatorIcon = 'assets/images/calculator.svg';
  final String ListIcon = 'assets/images/list-bullet.svg';
  final String DocumentIcon = 'assets/images/document-text.svg';


  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => TransportOrdersListModel());
  }

  @override
  void dispose() {
    //_model.dispose();
    super.dispose();
  }
  setHeight(){
    
    int height = 320;

    if(Data.is_driver)   height = 370;
    return height.toDouble();
  }
  showName(){
    String text = widget.info.barcode;
    if(Data.is_driver){
      text = widget.info.manufacturer;
    }
    else if(Data.is_product){
      text = widget.info.name;
    }
    return text;
   
  }
  showDesc(){
    String text = widget.info.description;
    if(Data.is_product){
      text =  '背景能耗 ${widget.info.background_emissions_percent} %';
    }

    return text;
  }
  getPath(){
    String path = '/transport-lot-info';
 
    Data.lot_barcode = widget.info.barcode;
    if(Data.is_driver){
      Data.transport_id = widget.info.id;
      path = '/transport-order-info';
    }
    else if(Data.is_product){
      Data.transport_id = widget.info.id;
      path = '/manufacture-info';
    }
    return path;
  }
  @override
  Widget build(BuildContext context) {
    
    return 
             Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: setHeight(),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        Data.is_driver || Data.is_product ? widget.info.custom_id : widget.info.name,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 20,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                              
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                    
                              ),
                              child:Align(
  alignment: AlignmentDirectional(0, 0),
  child:ShowOrderStatus(status:widget.info.status),

                            )),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      TransportOrderBriefOne(icon:Data.is_driver? OfficeIcon : ViewIcon,title:showName()),
                      Data.is_driver == false? Container():TransportOrderBriefOne(icon:LocationIcon,title:widget.info.address_from),
                      TransportOrderBriefOne(icon:CalculatorIcon,title:'${widget.info.total_weight} kg'),
                      Data.is_driver == false? Container():TransportOrderBriefOne(icon:ListIcon,title:'${widget.info.total_item} 件物料'),
                      TransportOrderBriefOne(icon:DocumentIcon,title:showDesc()),
                      Data.is_driver ? Container(): Data.is_product ? TransportOrderBriefOne(icon:LocationIcon,title:widget.info.production_line['name']) :TransportOrderBriefOne(icon:LocationIcon,title:widget.info.warehouse),
                   
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: FFButtonWidget(
                            onPressed: () async{
                              print('Button pressed ...');
                             
                              String path = getPath();
                              Navigator.pushNamed(context,path);
                              //  final picture = await Camera().takePicture();
                              //  Navigator.of(context).pop();
                            },
                            text: '查看',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 30,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                    ],
                  ),
                ),
              );
  }
}
