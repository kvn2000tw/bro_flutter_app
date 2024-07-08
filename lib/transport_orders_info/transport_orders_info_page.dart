
import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/service.dart';
import 'package:bro_flutter_app/transport_orders_info/transport_orders_info_widget.dart';
import 'package:flutter/material.dart';

class TransportOrdersInfoPage extends StatefulWidget {
   TransportOrdersInfoPage({super.key});


  @override
  State<TransportOrdersInfoPage> createState() =>
      _TransportOrdersInfoState();
}

class _TransportOrdersInfoState
    extends State<TransportOrdersInfoPage> {
 
  bool loaded = true;
  @override
  void initState() {
    super.initState();
    loaded = true;
  }

  @override
  void dispose() {
   
    super.dispose();
  }

 Future<bool> _getTransportSelect()async{
    final respons = await Service.getTransportSelect();

    if(respons.statusCode == HttpStatus.ok){
      print('select');
      print(Data.transport.status);
      loaded = false;
    }

    return true;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getTransportSelect(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        print('_getTransportSelect()');
        return builder(context);
      }
    );
   
  }
  
  Widget builder(BuildContext context) {
    
     return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          backgroundColor: Colors.blue,
          elevation:10,
          title: Text('',
          style: TextStyle(color:Colors.white),)
        ),
      body: loaded == true ? Container():
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

