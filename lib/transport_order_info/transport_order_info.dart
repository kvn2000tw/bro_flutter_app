import 'dart:ffi';

import 'package:flutter/material.dart';

class ManufactureInfo{
  String id='';
  String custom_id='';
  String address_from='';
  String address_to='';
  String manufacturer='';
  String organization='';
  String note='';
  int initial_odometer=0;
  int final_odometer=0;
  int status = 0;
  List<dynamic> lots=[];
  Map<String,dynamic> lots_meta={};
  List<dynamic> attachs=[];
  int total_item=0;
  String total_weight='';
  String description = '';

   String name='';
   String barcode='';
   String warehouse='';
  int background_emissions_percent = 0;
  Map<String,dynamic> production_line = {};
  String unit = '1';
  String expect_weight = '30.0';
  String expect_started_at = '';
  String expect_ended_at = '';
  List<dynamic> checkables=[];
  
}
class TransportOrdersInfo{
  String id='';
  String custom_id='';
  String address_from='';
  String address_to='';
  String manufacturer='';
  String organization='';
  String note='';
  int initial_odometer=0;
  int final_odometer=0;
  int status = 0;
  List<dynamic> lots=[];
  Map<String,dynamic> lots_meta={};
  List<dynamic> attachs=[];
  int total_item=0;
  String total_weight='';
  String description = '';

   String name='';
   String barcode='';
   String warehouse='';
  int background_emissions_percent = 0;
  Map<String,dynamic> production_line = {};

  
}
   
  class TransportOrdersLotStatus{

  int status = 0; 
  String barcode = ''; 
  String note = '';
  String description = '';
  String weight = '';
  String volume = '';
  String container = '';
  String name='';
  List<dynamic> checkables=[];
  List<dynamic> attachments=[];
  
}
  class TransportLotInfo{
  String id='';
  int status = 0; 
  String barcode = ''; 
  String note = '';
  String description = '';
  String weight = '';
  String volume = '';
  String container = '';
  String name='';
  String warehouse_id = '';
  List<dynamic> attachs=[];
  
}
class WarehouseModel {
  WarehouseModel({
    this.id='',
    this.name=''
  });

  String id;
  String name;

  factory WarehouseModel.fromJson(Map<String, dynamic> json) => WarehouseModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  
  };
}
class User{
  String id='';
  String full_name='';
  List<dynamic> roles = [];
  String profile_photo_path = '';

}
final TransportOrdersStatus=['尚未派車','派車運輸','開始運輸','等待請求回覆','生產廠簽收','生產廠拒絕','開始回程','結束運輸','終止運輸'];

final TransportOrdersStatusColor=[Colors.grey,Colors.orange,Colors.blue,Colors.orange,Colors.green,Colors.red,Colors.blue,Colors.grey,Colors.red];

final TransportOrdersStatusBKColor=[Color(0xFFF3F4F6),Color(0xFFFEF9C3),Color(0xFFDBEAFE),Color(0xFFFEF9C3),Color(0xFFDCFCE7),Color(0xFFFEE2E2),Color(0xFFDBEAFE),Color(0xFFF3F4F6),Color(0xFFFEE2E2)];

final LotStatusArr=['尚未填寫','填寫完成','納入移轉','納入運輸','檢查完成','檢查不合格','已簽收','運輸中','完成運輸','納入倉儲','納入再製','再製投入','再製完成'];
   
final LotStatusColorArr=[
Colors.red,
Colors.green,
Color.fromARGB(255, 202, 138, 4),
Colors.blue,
Colors.green,
Colors.red,
Colors.green,
Colors.blue,
Colors.green,
Color.fromARGB(255, 202, 138, 4),
Color.fromARGB(255, 202, 138, 4),
Colors.blue,
Colors.green];

final LotStatusBKColorArr=[
Color.fromARGB(255, 254, 226, 226),//red
Color.fromARGB(255, 220, 252, 231),//green
Color.fromARGB(255, 254, 249, 195),//yellow
Color.fromARGB(255, 219, 234, 254),//blue
Color.fromARGB(255, 220, 252, 231),//green
Color.fromARGB(255, 254, 226, 226),//red
Color.fromARGB(255, 220, 252, 231),//green
Color.fromARGB(255, 219, 234, 254),//blue
Color.fromARGB(255, 220, 252, 231),//green
Color.fromARGB(255, 254, 249, 195),//yellow
Color.fromARGB(255, 254, 249, 195),//yellow
Color.fromARGB(255, 219, 234, 254),//blue
Color.fromARGB(255, 220, 252, 231)];//green

enum lot_status{
  CREATED(value: 0, label: "CREATED",name:'尚未填寫'),
  FILLED(value: 1, label: "FILLED",name:'填寫完成'),
  REQUESTED(value: 2, label: "REQUESTED",name:'納入移轉'),
  DISPATCHED(value: 3, label: "DISPATCHED",name:'納入運輸'),
  PASSED(value: 4, label: "PASSED",name:'檢查完成'),

  FAILED(value: 5, label: "FAILED",name:'檢查不合格'),
  CONFIRMED(value: 6, label: "CONFIRMED",name:'已簽收'),
  TRANSPORTING(value: 7, label: "TRANSPORTING",name:'運輸中'),
  TRANSPORTED(value: 8, label: "TRANSPORTED",name:'完成運輸'),
  STORED(value: 9, label: "STORED",name:'納入倉儲'),
  SCHEDULED(value: 10, label: "SCHEDULED",name:'納入再製'),
  PICKED(value: 11, label: "PICKED",name:'再製投入'),
  PRODUCED(value: 12, label: "PRODUCED",name:'再製完成');

    final int value;
    final String label;
    final String name;
   
  const lot_status({
    required this.value,
    required this.label,
    required this.name,
   
  });
}

enum transport_status{
  CREATED(value: 0, label: "CREATED"),
  DISPATCHED(value: 1, label: "DISPATCHED"),
  STARTED(value: 2, label: "STARTED"),
  REQUESTED(value: 3, label: "REQUESTED"),
  APPROVED(value: 4, label: "APPROVED"),

  REJECTED(value: 5, label: "REJECTED"),
  RETURNED(value: 6, label: "RETURNED"),
  FINISHED(value: 7, label: "FINISHED"),
  TERMINATED(value: 8, label: "TERMINATED");
  

    final int value;
    final String label;
  
  const transport_status({
    required this.value,
    required this.label,
   
  });
}

enum manufacture_status{
  CREATED(value: 0, label: "CREATED"),
  
  STARTED(value: 1, label: "STARTED"),
  
  FINISHED(value: 2, label: "FINISHED");

    final int value;
    final String label;
  
  const manufacture_status({
    required this.value,
    required this.label,
   
  });
}
final ManufactureStatusArr=['尚未再製','開始再製','再製完成'];
   
  
final ManufactureStatusColorArr=[

Color.fromARGB(255, 202, 138, 4),
Colors.blue,
Colors.green];

final ManufactureStatusBKColorArr=[
Color.fromARGB(255, 254, 249, 195),//yellow
Color.fromARGB(255, 219, 234, 254),//blue
Color.fromARGB(255, 220, 252, 231)];//green

