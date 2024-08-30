import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_model.dart';
import 'package:bro_flutter_app/manufacture_product/manufacture_product_detail_model.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_order/transport_order_attach_widget.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/dialog.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:bro_flutter_app/utils/show_button.dart';
import 'package:flutter_svg/svg.dart';


import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class ManufactureProductDetailWidget extends StatefulWidget {
  ManufactureProductDetailWidget({super.key,
  required this.index,
  required this.info,
  });
       
  late int index;
  late Map<String,dynamic> info;
  @override
  State<ManufactureProductDetailWidget> createState() => _ManufactureProductWidgetState();
}

class _ManufactureProductWidgetState extends State<ManufactureProductDetailWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ManufactureProductDetailModel _model;
 
  @override
  void initState() {
    super.initState();
  _model = createModel(context, () => ManufactureProductDetailModel());

  _model.textController ??= TextEditingController(text:widget.info['weight']??'');
  _model.textFieldFocusNode ??= FocusNode();


  }
  
  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
 
 _onOK()async{
  
  Data.runFunc = 'product';
    await Navigator.pushNamed(context,'/camera');
    
    if (context.mounted){
      Navigator.of(context).pop();
    }

    if(Data.httpRet == true){
      await Service.updateManufactureProduct(widget.info['barcode'],_model.textController!.text);

      if(Data.httpRet == true){
        showNotification('更改成品資訊','完成');
      }
    }
    Navigator.of(context).pop();
  
    FocusManager.instance.primaryFocus?.unfocus();
 }
 _onSave(){
  
  double old_weight = double.tryParse(widget.info['weight']??'') ?? 0;
  double new_weight = double.tryParse(_model.textController!.text) ?? 0;
  double avaliable = Data.products.meta['total_weight'] - old_weight;
  double total =  double.tryParse(Data.manufacture.expect_weight) ?? 0;
  double max_weight = total-avaliable;
  if(new_weight > max_weight){
    print('$old_weight $new_weight $avaliable $total $max_weight ');
    showAlert(context, "錯誤", "不能大於 $max_weight kg");
    return;
  }
  String title = '更新成品資訊？';
  List<String> contents = [];
  String buttonText = '確認';

  showTransportDialog(context, title, contents, buttonText, _onOK);

 }
  @override
  Widget build(BuildContext context) {
   
    List<Widget> list = [];
    if(widget.info['attachments'] != null){
    for(var i = 0; i < widget.info['attachments'].length; i++){
        list.add(TransportOrderAttachWidget(attach:widget.info['attachments'][i]));
    }
    }

    return 
// Generated code for this Column Widget...
Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
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
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  InkWell(
  onTap: () {Navigator.of(context).pop();}, // Handle your callback
  child: 
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/iconLeftArrow_3x.png',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            widget.info['barcode'],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 21,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SvgPicture.asset(
                        'assets/images/camera.svg',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text(
                  '重量',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: false,
                              readOnly: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        'kg',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Text(
            '附件',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: Data.title_font,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: list,
        ),
      ),
    ),
   ShowButton(show:true,title:'儲存',onPressed: _onSave,),
  ],
);

  }

}
