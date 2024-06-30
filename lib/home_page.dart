
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bro_flutter_app/runing_page.dart';
import 'package:bro_flutter_app/transport_orders_list/transport_orders_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    RuningPage(),
    TransportOrdersListWidget(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final String TruckIcon = 'assets/images/truck.svg';
  final String ListIcon = 'assets/images/list-bullet.svg';
  final String CogIcon = 'assets/images/cog.svg';

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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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

