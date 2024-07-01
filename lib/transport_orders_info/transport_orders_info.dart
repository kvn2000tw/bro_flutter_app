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

final TransportOrdersStatus=['尚未派車','派車運輸','開始運輸','等待請求回覆','生產廠簽收','生產廠拒絕','開始回程','結束運輸','終止運輸'];

final TransportOrdersStatusColor=[Colors.grey,Colors.yellow,Colors.blue,Colors.yellow,Colors.green,Colors.red,Colors.blue,Colors.grey,Colors.red];

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
