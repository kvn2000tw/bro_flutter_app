
import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/manufacture_product/manufacture_product_detail_widget.dart';
import 'package:bro_flutter_app/transport_lot_status/transport_lot_status_widget.dart';

import 'package:flutter/material.dart';

class ManufactureProductPage extends StatefulWidget {
  const ManufactureProductPage({super.key});

  @override
  State<ManufactureProductPage> createState() =>
      _ManufactureProductState();
}

class _ManufactureProductState
    extends State<ManufactureProductPage> {
 
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
          title: Text(Data.products.list[Data.product_index]['barcode'],
          style: TextStyle(color:Colors.white),)
        ),
      body:  ManufactureProductDetailWidget(
        index:Data.product_index,
        info:Data.products.list[Data.product_index]
      )   
    );
  }
}


