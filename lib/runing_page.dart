
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_widget.dart';


import 'package:flutter/material.dart';


class RuningPage extends StatefulWidget {
  const RuningPage({super.key});

  @override
  State<RuningPage> createState() => _Page1WidgetState();
}

class _Page1WidgetState extends State<RuningPage>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    
    return TransportOrdersInfoWidget(
      title:'執行中的運輸單',hasAction:true,
      info:Data.current

    );
   
  }
}
