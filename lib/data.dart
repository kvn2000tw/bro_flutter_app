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
  static ManufactureProducts products = ManufactureProducts();
  static TransportOrdersInfo current = TransportOrdersInfo();
  static TransportOrdersInfo transport = TransportOrdersInfo();
  static TransportOrdersInfo transport_info = TransportOrdersInfo();
  static TransportOrdersLotStatus lotStatus = TransportOrdersLotStatus();
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
  static String arttach = '';
  static List<ValueNotifier<bool>> filter = [ValueNotifier(false),ValueNotifier(false),
  ValueNotifier(false),ValueNotifier(false),ValueNotifier(false),ValueNotifier(false),
  ValueNotifier(false),ValueNotifier(false),ValueNotifier(false)];
  static var search = '';
  static int page = 0;
  static bool read_more = true;
  static bool is_driver = false;
  static bool is_product = false;
  static ManufactureInfo manufacture = ManufactureInfo();
  static int product_index = 0;
  static String tmp_value='';
  static String tmp_note='';
  static bool isLogout = false;
  static double header_font = 18;
  static double title_font = 16;
  static double normal_font = 14;

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

    current.isgmap = response['current']['isgmap'];
    current.gmap = response['current']['gmap'];
     
    transport_info = current;
    
  }
  static setTransportSelect(Map<String,dynamic> response){
    debugPrint('setTransportSelect ${response}');
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

    transport.isgmap = response['isgmap'];
    transport.gmap = response['gmap'];
     
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
    lotStatus.warehouse_id = response['warehouse_id'] ?? '';
    lotStatus.weight = response['weight'].toString();
    lotStatus.checkables = response['checkables'] ?? [];
    lotStatus.attachments = response['attachments']??[];

  }
  static setManufacturerProducts(Map<String,dynamic> response){
    products.list = response['products'] ?? [];
    products.meta = response['products_meta'] ?? {};

  }
  static resetPage(){
    print('resetPage');
    page = 1;
    ordersList = [];
    read_more = true;

  }
  static setManufactureInfo(Map<String,dynamic> response){
    manufacture.id = response['id'];
    manufacture.name = response['name'];
    manufacture.status = response['status'];
    manufacture.unit = response['unit'];
    manufacture.expect_weight = response['expect_weight'];
    manufacture.background_emissions_percent = response['background_emissions_percent'];
    manufacture.production_line = response['production_line'];
    manufacture.description = response['description'] ?? '';
    manufacture.note = response['note'] ?? '';

    manufacture.expect_started_at = response['expect_started_at'] ?? '';
    manufacture.expect_ended_at = response['expect_ended_at'] ?? '';    

    manufacture.lots = response['lots'] ?? [];
    manufacture.lots_meta = response['lots_meta'];
    manufacture.attachs = response['attachments'] ?? [];
    manufacture.checkables = response['checkables'] ?? [];

    
  }
  static setTransportOrders(Map<String,dynamic> response){
    //ordersList.clear();
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
      
      item.barcode = response['items'][i]['barcode'] ?? '';
     
      item.description = response['items'][i]['description']??'';
      if(is_driver){
         item.total_item = response['items'][i]['lots_meta']['total_item'];
        item.manufacturer = response['items'][i]['manufacturer']['name']??'';
        item.total_weight = response['items'][i]['lots_meta']['total_weight'].toString();
      }else if(is_product){
        item.total_weight = response['items'][i]['expect_weight'];
        item.background_emissions_percent = response['items'][i]['background_emissions_percent'];
        item.production_line = response['items'][i]['production_line'];
      }else {
        item.total_weight = response['items'][i]['weight'].toString();
      }
     
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
   
    is_driver = user.roles.contains('driver');
    is_product = user.roles.contains('production_manager');

  }

  static setUploadUrl(Map<String,dynamic> response){
    presignedUrl = response['presignedUrl'];
    url_key = response['key'];
  }
}