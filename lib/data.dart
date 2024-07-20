import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Token{
  String token_type='';
  int expires_in=0;
  String access_token='';

}


class Data {
  static Token token = Token();
  static TransportOrdersInfo current = TransportOrdersInfo();
  static TransportOrdersInfo transport = TransportOrdersInfo();
  static TransportOrdersInfo transport_info = TransportOrdersInfo();
  static TransportOrdersLotStatus lotStatus = TransportOrdersLotStatus();
  static TransportLotInfo lotInfo = TransportLotInfo();
  static List<TransportOrdersInfo> ordersList = [];
  static List<WarehouseModel> warehouse=[];
  static User user = User();
  static String lot_barcode='';
  static String transport_id='';
  static String errorMessage = '';
  static bool isAutoLogin = false;
  static String presignedUrl = '';
  static String url_key = '';
  static bool isCurrent = false;
  static String runFunc = '';
  static bool httpRet = false;
  static int sort = 0;
  static List<ValueNotifier<bool>> filter = [ValueNotifier(false),ValueNotifier(false),
  ValueNotifier(false),ValueNotifier(false),ValueNotifier(false),ValueNotifier(false)];
  static var search = '';
  static int page = 0;
  static bool read_more = true;
  static setToken(Map<String,dynamic> response){
    print('setToken ${response}');
   
    token.token_type = response["token"]["token_type"];
    token.expires_in = response['token']["expires_in"];
    token.access_token = response['token']["access_token"];

  }

  static setTransportCurrent(Map<String,dynamic> response){
    debugPrint('setTransportCurrent ${response}');
    if(response['current'] == null){
      current.id = '';
      transport_info = current;
      return;
    }
    current.id = response['current']['id'];
    current.custom_id = response['current']['custom_id'];
    current.address_from = response['current']['address_from'];
    current.address_to = response['current']['address_to'];
    current.manufacturer = response['current']['manufacturer']['name'];
    current.organization = response['current']['organization']['name'];
    current.note = response['current']['note'] ?? '';
    current.initial_odometer = response['current']['initial_odometer'] ?? 0;
    current.final_odometer = response['current']['final_odometer'] ?? 0;
    current.status = response['current']['status'];
    current.lots = response['current']['lots'];
    current.lots_meta = response['current']['lots_meta'];
    current.attachs = response['current']['attachments'];

    transport_info = current;
    
  }
  static setTransportLotInfo(Map<String,dynamic> response){
    debugPrint('setTransportLot ${response}');
   
    lotInfo.id = response['id'];
    lotInfo.status = response['status'];
    lotInfo.barcode = response['barcode'];
    lotInfo.note = response['note']??'';
    lotInfo.description = response['description'];
    lotInfo.weight = response['weight'];
   
    lotInfo.volume = response['volume'];
    lotInfo.container = response['container'];
    lotInfo.name = response['name'];
    lotInfo.warehouse_id = response['warehouse_id'];
    lotInfo.attachs = response['attachments']??[];
    
  }

  static setTransportSelect(Map<String,dynamic> response){
    debugPrint('setTransportCurrent ${response}');
    transport.id = response['id'];
    transport.custom_id = response['custom_id'];
    transport.address_from = response['address_from'];
    transport.address_to = response['address_to'];
    transport.manufacturer = response['manufacturer']['name'];
    transport.organization = response['organization']['name'];
    transport.note = response['note'] ?? '';
    transport.initial_odometer = response['initial_odometer'] ?? 0;
    transport.final_odometer = response['final_odometer'] ?? 0;
    transport.status = response['status'];
    transport.lots = response['lots'];
    transport.lots_meta = response['lots_meta'];
    transport.attachs = response['attachments']??[];
     
    transport_info = transport;
    
  }

  static setTransportWarehouse(Map<String,dynamic> response){
    debugPrint('setTransportWarehouse ${response}');
   
    
  }

  static setTransportLotStatus(Map<String,dynamic> response){
    lotStatus.name = response['name'];
    lotStatus.barcode = response['barcode'];
    lotStatus.status = response['status'];
    lotStatus.container = response['container'];
    lotStatus.note = response['note'] ?? '';
    lotStatus.volume = response['volume'];
    lotStatus.weight = response['weight'].toString();
    lotStatus.checkables = response['checkables'];
    lotStatus.attachments = response['attachments']??[];

  }

  static setTransportOrders(Map<String,dynamic> response){
    //ordersList.clear();
    bool is_driver = user.roles.contains('driver');
    if(response['items'].length == 0){
      read_more = false;
      return;
    }
    for(var i=0;i<response['items'].length;i++){
      var item = TransportOrdersInfo();
      item.id = response['items'][i]['id'];
      item.custom_id = response['items'][i]['custom_id'] ?? '';
      item.name = response['items'][i]['name'] ?? '';
      item.status = response['items'][i]['status'];
      item.address_from = response['items'][i]['address_from'] ?? '';
      item.manufacturer = is_driver == false ? '' :response['items'][i]['manufacturer']['name']??'';
      item.barcode = response['items'][i]['barcode'] ?? '';
      item.total_item = is_driver == true ? response['items'][i]['lots_meta']['total_item'] : 0;
      item.description = response['items'][i]['description']??'';
      item.total_weight = is_driver == true ? response['items'][i]['lots_meta']['total_weight'].toString() : response['items'][i]['weight'].toString();
      
      //item.warehouse = response['items'][i]['warehouse'] ? response['items'][i]['warehouse']['name'] :  '';
      if(response['items'][i]['warehouse'] != null)
        item.warehouse = response['items'][i]['warehouse']['name'];
      ordersList.add(item);
    }
  }
  
  static setProfile(Map<String,dynamic> response){

    user.id = response['user']['id'];
    user.full_name = response['user']['full_name'];
    user.roles = response['user']['roles'];
    user.profile_photo_path = response['user']['profile_photo_path'] ?? '';
   
  }

  static setUploadUrl(Map<String,dynamic> response){
    presignedUrl = response['presignedUrl'];
    url_key = response['key'];
  }
}