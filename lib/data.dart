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
  static List<TransportOrdersInfo> ordersList = [];
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

  static setTransportOrdersList(Map<String,dynamic> response){
    ordersList.clear();
    
    for(var i=0;i<response['items'].length;i++){
      var item = TransportOrdersInfo();
      item.id = response['items'][i]['id'];
      item.custom_id = response['items'][i]['custom_id'];
      item.status = response['items'][i]['status'];
      item.address_from = response['items'][i]['address_from'];
      item.manufacturer = response['items'][i]['manufacturer']['name'];
      item.total_item = response['items'][i]['lots_meta']['total_item'];
      item.description = response['items'][i]['description']??'';
      item.total_weight = response['items'][i]['lots_meta']['total_weight'].toString();

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