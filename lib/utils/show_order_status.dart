import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:flutter/material.dart';

import '../data.dart';


class ShowOrderStatus extends StatelessWidget {
  
  ShowOrderStatus({required this.status,})
  {
    
  }

  late int status;
  @override
  Widget build(BuildContext context) {
    bool is_driver = Data.user.roles.contains('driver');
   return DecoratedBox(
   decoration: BoxDecoration(
  color:is_driver ? TransportOrdersStatusBKColor[status] :LotStatusBKColorArr[status]
   ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Text(
      is_driver ? TransportOrdersStatus[status]:LotStatusArr[status],
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            letterSpacing: 0,
            fontSize: 13,
            fontWeight:FontWeight.w600,
            color:is_driver? TransportOrdersStatusColor[status]:LotStatusColorArr[status]
          ),
    ),
  )
);
  }
}