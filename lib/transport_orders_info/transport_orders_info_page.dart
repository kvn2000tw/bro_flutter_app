
import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bro_flutter_app/runing_page.dart';
import 'package:bro_flutter_app/transport_orders_list/transport_orders_list_widget.dart';

class TransportOrdersInfoPage extends StatefulWidget {
  const TransportOrdersInfoPage({super.key});

  @override
  State<TransportOrdersInfoPage> createState() =>
      _TransportOrdersInfoState();
}

class _TransportOrdersInfoState
    extends State<TransportOrdersInfoPage> {

    bool isLoad = true;
  _getTransportSelect()async{
    final respons = await Service.getTransportSelect();

    if(respons.statusCode == HttpStatus.ok){

      setState(() {
        isLoad = false;
      });
    }

  }
  @override
  void initState() {
    super.initState();
    isLoad = true;
    _getTransportSelect();
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
      body:isLoad == true ? Container() : 
      Center(
        child: TransportOrdersInfoWidget(
          title:'運輸單資訊',
          hasAction:true,
          hasReturn:true,
          info:Data.transport),
      ),
     
    );
  }
}

