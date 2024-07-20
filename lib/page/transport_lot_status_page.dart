
import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_lot_status/transport_lot_status_widget.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';

import 'package:bro_flutter_app/transport_order_status/transport_order_status_item.dart';
import 'package:bro_flutter_app/transport_order_status/transport_order_status_item_info.dart';
import 'package:bro_flutter_app/utils/alert.dart';
import 'package:bro_flutter_app/utils/dialog.dart';
import 'package:bro_flutter_app/utils/notify.dart';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';

class TransportLotStatusPage extends StatefulWidget {
  const TransportLotStatusPage({super.key});

  @override
  State<TransportLotStatusPage> createState() =>
      _TransportLotStatusState();
}

class _TransportLotStatusState
    extends State<TransportLotStatusPage> {
 
  @override
  void initState() {
    super.initState();
   
   
  }

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

     return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          backgroundColor: Colors.blue,
          elevation:10,
          title: Text(Data.lot_barcode,
          style: TextStyle(color:Colors.white),)
        ),
      body:  TransportLotStatusWidget()   
    );
  }
}


