import 'package:bro_flutter_app/transport_orders_info/transport_orders_info.dart';
import 'package:flutter/material.dart';

class Token{
  String token_type='';
  int expires_in=0;
  String access_token='';

}


class Data {
  static Token token = Token();
  static TransportOrdersInfo current = TransportOrdersInfo();
  static TransportOrdersLotStatus lotStatus = TransportOrdersLotStatus();
  static String lot_barcode='';
  static setToken(Map<String,dynamic> response){
    print('setToken ${response}');
   
    token.token_type = response["token"]["token_type"];
    token.expires_in = response['token']["expires_in"];
    token.access_token = response['token']["access_token"];

  }

  static setTransportCurrent(Map<String,dynamic> response){
    debugPrint('setTransportCurrent ${response}');
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
    
  }

  static setTransportLotStatus(Map<String,dynamic> response){
    lotStatus.name = response['name'];
    lotStatus.container = response['container'];
    lotStatus.note = response['note'] ?? '';
    lotStatus.volume = response['volume'];
    lotStatus.weight = response['weight'].toString();
    lotStatus.checkables = response['checkables'];
    lotStatus.attachments = response['attachments'];

  }
}