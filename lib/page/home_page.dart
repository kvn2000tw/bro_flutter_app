import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/page/runing_page.dart';
import 'package:bro_flutter_app/page/setting_page.dart';
import 'package:bro_flutter_app/page/transport_orders_page/transport_orders_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key,
  this.item});

  int? item;
  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 0;
  bool isLoad = true;
 
  List<Widget> _widgetOptions = [];

  void _onItemTapped(int index)async {
    if(index == 0){
      Data.isCurrent = true;
    }else {
      Data.isCurrent = false;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
  final String TruckIcon = 'assets/images/truck.svg';
  final String ListIcon = 'assets/images/list-bullet.svg';
  final String CogIcon = 'assets/images/cog.svg';

  @override
  void initState() {
    super.initState();

  _widgetOptions = <Widget>[
    RuningPage(onTap:()=>_onItemTapped(1)),
    const TransportOrdersPage(),
    const SettingPage()
  ];
  
    _selectedIndex = 0;
    Data.isCurrent = true;
    
    isLoad = false;
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
          title: const Text('',
          style: TextStyle(color:Colors.white),)
        ),
      body: isLoad == true ? Container():Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: isLoad == true? null : BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
          TruckIcon,
          colorFilter: ColorFilter.mode(_selectedIndex==0?Colors.blue:Colors.black, BlendMode.srcIn),),
            label: '執行中',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ListIcon,
              colorFilter: ColorFilter.mode(_selectedIndex==1?Colors.blue:Colors.black, BlendMode.srcIn),),

            label: '運輸單列表',
          ),
          BottomNavigationBarItem(
            icon:  SvgPicture.asset(
                  CogIcon,
                  colorFilter: ColorFilter.mode(_selectedIndex==2?Colors.blue:Colors.black, BlendMode.srcIn),),
            label: '系統設定',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
