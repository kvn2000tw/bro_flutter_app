
import 'package:bro_flutter_app/login/login_admin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Login extends StatelessWidget {
  Login({super.key});

  //late TabController _tabController;
  final List tabs = ["再製廠", "生產廠"];

  @override
    Widget build(BuildContext context) {
    return 
     Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.blue,
          elevation:10,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text('智慧回收碳記錄稽核管理系統',
          style: TextStyle(color:Colors.white),),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    tabs: tabs.map((e) => Tab(text: e)).toList(),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                 children: const [LoginAdminWidget(),LoginAdminWidget()]
                ),
              ),
            ],
          ),
        ),
      );
  }

}
