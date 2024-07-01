import 'dart:convert';
import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:dio/dio.dart';

class Service{
  //static final dio = Dio();
  static login() async {
        String url = "https://recycle-server.realco2tech.com/api/app/admin/account/login";
        // Or create `Dio` with a `BaseOptions` instance.
        final options = BaseOptions(
        baseUrl: url,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
        headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );
        final dio = Dio(options);
     
      Response response;
      final data = {"client_id": "992dc968-cd56-4c45-b3ea-cdc5e900a241", "client_secret":"b3olcQpSiQ7ccSsnEb3Nw38My1jykS4JDoFV0Tk4", "deviceAddress":"cT-EI8A3QcSr46krZn6w5N:APA91bF1cpxy2bxuP3MBBW130dG55EH1mZsWlB_AWZvprXD3jbrkRS5G0y7knP3YfMY260iJ9XWFKFQzEaOscFTZc6nIA4UQaNvwUq_5ZYo0YzlLlnqVmsdkklKABjDD_u17o1BYUUmK","deviceSystemInfo": {"deviceModel": "Shadow", "deviceName": "unknown", "osVersion": "14", "platform": "android", "uniqueId": "ae79c7ea4a3241df"}, "deviceType": 0, "grant_type": "password", "organization_vat": "90282846", "password": "12345678", "platform": 1, "username": "driver@lce-alloy.com"};

      response = await dio.post(url, data: data);

      //print(response.data.toString());

      if(response.statusCode == HttpStatus.ok){
       
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        //print(fromJsonMap);
        Data.setToken(fromJsonMap);
      }
    
      return response;
  }

  static getTransportCurrent()async {
    
    String url = "https://recycle-server.realco2tech.com/api/app/admin/transport-orders/current";
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      response = await dio.get(url);

      if(response.statusCode == HttpStatus.ok){
         Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print(fromJsonMap);
        Data.setTransportCurrent(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return response;
  }

  static getTransportSelect()async {
    
    String url = "https://recycle-server.realco2tech.com/api/app/admin/transport-orders/${Data.transport_id}";
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      response = await dio.get(url);

      if(response.statusCode == HttpStatus.ok){
         Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print(fromJsonMap);
        Data.setTransportSelect(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return response;
  }

  static getLotStatus(String barcode)async{
    String url = 'https://recycle-server.realco2tech.com/api/app/admin/lots/barcode/${barcode}';
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      response = await dio.get(url);

      if(response.statusCode == HttpStatus.ok){
         Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
         print('getLotStatus');
        //print(fromJsonMap);
        Data.setTransportLotStatus(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return response;
  }
  static GetTransportOrders()async{
    String url = 'https://recycle-server.realco2tech.com/api/app/admin/transport-orders/index?page=1';
    // Or create `Dio` with a `BaseOptions` instance.
    Map<String, List> data = {"filters": [], "sorts": []};
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
      
        );
        final dio = Dio(options);
     
      Response response;
    
      response = await dio.post(url,data:data);

      if(response.statusCode == HttpStatus.ok){
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('GetTransportOrders');
        print(fromJsonMap);
        Data.setTransportOrdersList(fromJsonMap);
      }

      return response;
  }
  
}