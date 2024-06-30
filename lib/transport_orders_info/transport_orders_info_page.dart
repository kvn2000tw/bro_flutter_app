
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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: Center(
        child: TransportOrdersInfoWidget(
          title:'運輸單資訊'),
      ),
     
    );
  }
}

