import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:flutter/material.dart';

import '../data.dart';


class ShowOrderStatus extends StatelessWidget {
  
  ShowOrderStatus({required this.status,})
  {
    
  }

  late int status;

  showBKColor(){
    Color color = LotStatusBKColorArr[status];
    if(Data.is_driver){
      color = TransportOrdersStatusBKColor[status];
    }else if(Data.is_product){
      color = ManufactureStatusBKColorArr[status];
    }

    return color;
  }
  showColor(){
    Color color = LotStatusColorArr[status];
    if(Data.is_driver){
      color = TransportOrdersStatusColor[status];
    }else if(Data.is_product){
      color = ManufactureStatusColorArr[status];
    }

    return color;
  }

  showText(){
    String text = LotStatusArr[status];

    if(Data.is_driver){
      text = TransportOrdersStatus[status];
    }else if(Data.is_product){
      text = ManufactureStatusArr[status];
    }
   
    return text;
  }
  @override
  Widget build(BuildContext context) {
   
   return DecoratedBox(
   decoration: BoxDecoration(
  color:showBKColor(),
   ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Text(
      showText(),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            letterSpacing: 0,
            fontSize: 13,
            fontWeight:FontWeight.w600,
            color:showColor(),
          ),
    ),
  )
);
  }
}