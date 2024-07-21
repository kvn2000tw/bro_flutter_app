

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/manufacture_info/manufacture_info_widget.dart';
import 'package:bro_flutter_app/service.dart';

import 'package:flutter/material.dart';


class ManufaturePage extends StatefulWidget {
   ManufaturePage({super.key});


  @override
  State<ManufaturePage> createState() => _Page1WidgetState();
}

class _Page1WidgetState extends State<ManufaturePage>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoad = true;
  
  @override
  void initState() {
    super.initState();
    isLoad = true;
  }

  @override
  void dispose() {

    super.dispose();
  }

Future<bool> _getManufactureInfo()async{

  //   var response =  await http.get('https://getProjectList');    
   final ret = await Service.getManufactureInfo();
    isLoad = false;
   return ret;
}

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<bool>(
      future: _getManufactureInfo(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
         return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          backgroundColor: Colors.blue,
          elevation:10,
          title: Text('',
          style: TextStyle(color:Colors.white),)
        ),
      body: isLoad  ? Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            ):
      ManufactureInfoWidget(
          title:'再製單資訊',hasAction:true,
          hasReturn:true,
          info:Data.manufacture

        )
     
    );
      }
    );
   
  }
}
