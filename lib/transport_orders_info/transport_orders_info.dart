import 'dart:ffi';

import 'package:flutter/material.dart';

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
}
   
  class TransportOrdersLotStatus{
  
  String note = '';
  String description = '';
  String weight = '';
  String volume = '';
  String container = '';
  String name='';
  List<dynamic> checkables=[];
  List<dynamic> attachments=[];
  
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

enum lot_status{
  CREATED(value: 0, label: "CREATED"),
  FILLED(value: 1, label: "FILLED"),
  REQUESTED(value: 2, label: "REQUESTED"),
  DISPATCHED(value: 3, label: "DISPATCHED"),
  PASSED(value: 4, label: "PASSED"),

  FAILED(value: 5, label: "FAILED"),
  CONFIRMED(value: 6, label: "CONFIRMED"),
  TRANSPORTING(value: 7, label: "TRANSPORTING"),
  TRANSPORTED(value: 8, label: "TRANSPORTED"),
  STORED(value: 9, label: "STORED"),
  SCHEDULED(value: 10, label: "SCHEDULED"),
  PICKED(value: 11, label: "PICKED"),
  PRODUCED(value: 12, label: "PRODUCED");

    final int value;
    final String label;
  
  const lot_status({
    required this.value,
    required this.label,
   
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
