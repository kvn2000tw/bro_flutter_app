
import 'package:bro_flutter_app/transport_lot_status/transport_lot_status_widget.dart';

import 'package:flutter/material.dart';

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
          title: Text('',
          style: TextStyle(color:Colors.white),)
        ),
      body:  TransportLotStatusWidget()   
    );
  }
}


