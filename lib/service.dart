import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_util.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:dio/dio.dart';
import 'dart:io' as io;

class Service{
  //static final dio = Dio();
  static String BaseUrl = 'https://recycle-server.realco2tech.com/api/app';
  static setSite(String site){
    if(site == "1"){
      BaseUrl = 'https://recycle-server.realco2tech.com/api/app';
    }
    else if(site == "2"){
      BaseUrl = 'https://dev-recycle-server.realco2tech.com/api/app';
    }
  }
  static login(String code,String user,String passwd) async {
        String url = "$BaseUrl/admin/account/login";
        print('login $url');
        // Or create `Dio` with a `BaseOptions` instance.
        final options = BaseOptions(
        baseUrl: url,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
          "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
        );
        final dio = Dio(options);
     
      Response response;
      //final data = {"client_id": "992dc968-cd56-4c45-b3ea-cdc5e900a241", "client_secret":"b3olcQpSiQ7ccSsnEb3Nw38My1jykS4JDoFV0Tk4", "deviceAddress":"cT-EI8A3QcSr46krZn6w5N:APA91bF1cpxy2bxuP3MBBW130dG55EH1mZsWlB_AWZvprXD3jbrkRS5G0y7knP3YfMY260iJ9XWFKFQzEaOscFTZc6nIA4UQaNvwUq_5ZYo0YzlLlnqVmsdkklKABjDD_u17o1BYUUmK","deviceSystemInfo": {"deviceModel": "Shadow", "deviceName": "unknown", "osVersion": "14", "platform": "android", "uniqueId": "ae79c7ea4a3241df"}, "deviceType": 0, "grant_type": "password", "organization_vat": "90282846", "password": "12345678", "platform": 1, "username": "driver@lce-alloy.com"};
      Map<String,dynamic> data = {"client_id": "992dc968-cd56-4c45-b3ea-cdc5e900a241", "client_secret":"b3olcQpSiQ7ccSsnEb3Nw38My1jykS4JDoFV0Tk4", "deviceAddress":"cT-EI8A3QcSr46krZn6w5N:APA91bF1cpxy2bxuP3MBBW130dG55EH1mZsWlB_AWZvprXD3jbrkRS5G0y7knP3YfMY260iJ9XWFKFQzEaOscFTZc6nIA4UQaNvwUq_5ZYo0YzlLlnqVmsdkklKABjDD_u17o1BYUUmK","deviceSystemInfo": {"deviceModel": "Shadow", "deviceName": "unknown", "osVersion": "14", "platform": "android", "uniqueId": "ae79c7ea4a3241df"}, "deviceType": 0, "grant_type": "password", "organization_vat": "90282846", "password": "12345678", "platform": 1, "username": "driver@lce-alloy.com"};
      data["organization_vat"] = code;
      data["password"] = passwd;
      data["username"] = user;
      bool ret = false;
      try {
      response = await dio.post(url, data: data);

      //print(response.data.toString());

      if(response.statusCode == HttpStatus.ok){
       
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        //print(fromJsonMap);
        Data.setToken(fromJsonMap);
        await profile();

        ret = true;
      }
    
    }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      if (e.response != null) {
        print(e.response?.data);
       
        Map<String,dynamic> fromJsonMap = jsonDecode(e.response.toString());
        if(fromJsonMap['errorCode'] == 400){
          print(fromJsonMap['errors']);
          if(fromJsonMap['errors']['password'] != null){
            Data.errorMessage = fromJsonMap['errors']['password'][0];
          }
          else if(fromJsonMap['errors']['organization_vat'] != null){
            Data.errorMessage = fromJsonMap['errors']['organization_vat'][0];

          }
        }else if(fromJsonMap['errorCode'] == 6){
          print(fromJsonMap['message']);
          Data.errorMessage = fromJsonMap['message'];
        }

      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
      
      return ret;
  }

  static getTransportCurrent()async {
    
    String url = "$BaseUrl/admin/transport-orders/current";
    print('getTransportCurrent $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    bool ret = false;
    try {
      response = await dio.get(url);

      if(response.statusCode == HttpStatus.ok){
         Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('getTransportCurrent');
        print(fromJsonMap);
        Data.setTransportCurrent(fromJsonMap);
        ret = true;
      }

    }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      if (e.response != null) {
        print(e.response?.data);
       
        Map<String,dynamic> fromJsonMap = jsonDecode(e.response.toString());
       

      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return ret;
  }

  static getTransportWarehouse()async {
    
    String url = "$BaseUrl/admin/warehouse";
    print('getTransportWarehouse $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
    Response response;
    bool ret = false;
    try {
     response = await dio.get(url);
     if(response.statusCode == HttpStatus.ok){
      // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
      
      Data.warehouse = (response.data as List)
          .map((x) => WarehouseModel.fromJson(x))
          .toList();
      
      ret = true;
     }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }

      return ret;
  }

  static updateLotInfo(String note,String weight,String warehouse)async {
    
    String url = "$BaseUrl/admin/warehouse/lots/barcode/${Data.lotStatus.barcode}";
    print('updateLotInfo $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
    Response response;
    bool ret = false;
    try {
      Map<String,dynamic> data = {"weight": weight};
      if(Data.arttach != ''){
        data["attachments"] = [Data.arttach];
        data["warehouse_id"] = warehouse;
      }
       
      data["note"] = (note == '' ? null:note);
      
      print('data');
      print(data);
     response = await dio.put(url,data:data);
     if(response.statusCode == HttpStatus.ok){
      // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print(fromJsonMap);

      ret = true;
     }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }

      return ret;
  }

  static getTransportSelect()async {
    
    String url = "$BaseUrl/admin/transport-orders/${Data.transport_id}";
    print('getTransportSelect $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
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

    String url = '$BaseUrl/admin/lots/barcode/${barcode}';
    if(!Data.is_driver)
      url = '$BaseUrl/admin/warehouse/lots/barcode/${barcode}';
    print('getLotStatus $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
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
         Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
         print('getLotStatus');
        print(fromJsonMap);
        Data.setTransportLotStatus(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return response;
  }
  
  
  static manufacturerCancelPicked()async{

    String url = '$BaseUrl/admin/manufacturer-orders/lots/${Data.lotStatus.barcode}/cancelPicked';
   
    print('manufacturerCancelPicked $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
            "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
      
        );
        final dio = Dio(options);

    bool ret = false; 
    try{
      Response response;
    
      response = await dio.put(url);

      if(response.statusCode == HttpStatus.ok){
    
        ret = true;
      }
    }
    on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }
    static updateManufactureProduct(String barcode,String weight)async{
    String url = "$BaseUrl/admin/manufacturer-orders/products/$barcode";
    print('updateManufactureProduct $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      Data.httpRet = false;
      try{
      response = await dio.put(url,data: {"weight": weight,"attachments":[Data.arttach]});

      if(response.statusCode == HttpStatus.ok){
        Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        Data.products.list[Data.product_index]['weight'] = fromJsonMap['weight'];
       Data.httpRet = true;
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
    
  }  
  
  static updateManufacture(String id,Map<String,dynamic> map)async{
    String url = "$BaseUrl/admin/manufacturer-orders/$id";
    print('updateManufacture $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
            "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      Data.httpRet = false;
     print(map);
      try{
      response = await dio.put(url,data:map);

      if(response.statusCode == HttpStatus.ok){
        Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        print(fromJsonMap);
        Data.manufacture.expect_started_at = fromJsonMap['expect_started_at'] ?? '';
        Data.manufacture.expect_ended_at = fromJsonMap['expect_ended_at'] ?? '';    

        Data.httpRet = true;
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
    
  }  

    static updateManufactureCheckable(String id,List<dynamic> list)async{
    String url = "$BaseUrl/admin/manufacturer-orders/$id/checkable";
    print('updateManufactureCheckable $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
            "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      Data.httpRet = false;
      var data = {"checkable": list};
    
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       
       Data.httpRet = true;
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
    
  }  

  static manufacturerPicked()async{

    String url = '$BaseUrl/admin/manufacturer-orders/lots/${Data.lotStatus.barcode}/picked';
   
    print('manufacturerPicked $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
            "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
      
        );
        final dio = Dio(options);

    bool ret = false; 
    try{
      Response response;
    
      response = await dio.put(url);

      if(response.statusCode == HttpStatus.ok){
    
        ret = true;
      }
    }
    on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }

      static manufacturerProducts()async{

    String url = '$BaseUrl/admin/manufacturer-orders/${Data.manufacture.id}/products';
   
    print('manufacturerProducts $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
            "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
      
        );
        final dio = Dio(options);

    bool ret = false; 
    try{
      Response response;
    
      response = await dio.get(url);

      if(response.statusCode == HttpStatus.ok){
        Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        print('manufacturerProducts');
         print(fromJsonMap);
        Data.setManufacturerProducts(fromJsonMap);
        ret = true;
      }
    }
    on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }

    static manufacturerFinish()async{

    String url = '$BaseUrl/admin/manufacturer-orders/${Data.manufacture.id}/finished';
   
    print('manufacturerFinish $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
            "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
      
        );
        final dio = Dio(options);

    bool ret = false; 
    try{
      Response response;
    
      response = await dio.put(url);

      if(response.statusCode == HttpStatus.ok){
        Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        print('manufacturerFinish');
        print(fromJsonMap);
        Data.manufacture.status = fromJsonMap['status'];
        ret = true;
      }
    }
    on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }

    static getManufactureInfo()async{

    String url = '$BaseUrl/admin/manufacturer-orders/${Data.transport_id}';
   
    print('getManufactureInfo $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
      
        );
        final dio = Dio(options);

    bool ret = false; 
    try{
      Response response;
    
      response = await dio.get(url);

      if(response.statusCode == HttpStatus.ok){
        Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        print('getManufactureInfo');
        print(fromJsonMap);
        Data.setManufactureInfo(fromJsonMap);

        ret = true;
      }else {
         Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
         Data.errorMessage = fromJsonMap['message'];
      }
    }
    on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }

  static GetTransportOrders()async{

    String url = '$BaseUrl/admin/warehouse/lots/index?page=${Data.page}';
    print("${Data.is_driver} ${Data.is_product}");
    if(Data.is_driver){
      url = '$BaseUrl/admin/transport-orders/index?page=${Data.page}';
    }else if(Data.is_product){
      url = '$BaseUrl/admin/manufacturer-orders/index?page=${Data.page}';
    }
    print('GetTransportOrders $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    List<Map<String,dynamic>> sorts = [];
    if(Data.is_driver){
    if(Data.sort == 1){
      sorts = [{"field":"updated_at","order":"desc","label":"最新","selected":true}];
    }
    else if(Data.sort == 2){
      sorts = [{"field":"updated_at","order":"asc","label":"最舊","selected":true}];
    }
    }else if(Data.is_product){
    if(Data.sort == 1){
      sorts = [{"field":"custom_id","order":"desc","label":"最新","selected":true}];
    }
    else if(Data.sort == 2){
      sorts = [{"field":"custom_id","order":"asc","label":"最舊","selected":true}];
    }

    }else {
    if(Data.sort == 1){
      sorts = [{"field":"created_at","order":"desc","label":"最新","selected":true}];
    }
    else if(Data.sort == 2){
      sorts = [{"field":"created_at","order":"asc","label":"最舊","selected":true}];
    }

    }
   
   List<Map<String,dynamic>> filters = [];

   if(Data.search != ""){
    filters.add({"field":"custom_id","value":Data.search});
   }

    List<Map<String,dynamic>> value = [];
    for(var i=0;i<Data.filter.length;i++){
      if(Data.filter[i].value == true){
                                          
        if(i==6){
          value.add( {"field":"weight","operator":"<","value":100});
        }else if(i==7){
          value.add( {"field":"weight","operator":"between","value":[100,1000]});

        }else if(i==8){
          value.add( {"field":"weight","operator":">","value":1000});

        }else {
           int index = i+7;
           if(Data.is_driver)
           {
            index = i+1;
           }
          else if(Data.is_product)
          { 
            index = i;
          }
          value.add( {"field":"status","operator":"=","value":index});
        }
      }
    }

    if(!value.isEmpty){
      filters.add(
        {"field":"status","value":value,"operator":"group"}
      );
    }

    Map<String, List> data = {"filters": filters, "sorts": sorts};
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
      
        );
        final dio = Dio(options);

    bool ret = false; 
    try{
      Response response;
      print(data);
      response = await dio.post(url,data:data);

      if(response.statusCode == HttpStatus.ok){
        print(response.toString());
        Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        print('GetTransportOrders');
        print(fromJsonMap);
        Data.setTransportOrders(fromJsonMap);

        ret = true;
      }
    }
    on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }
  
  static profile()async {
    
    String url = "$BaseUrl/admin/account/profile";
    print('profile $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
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
        Data.setProfile(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return response;
  }

  static upload_url(String uploadUrl)async{
    String url = "$BaseUrl/media/upload-url";
    print('profile $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      DateFormat dateFormat = DateFormat("yyyy-MM-dd_HH-mm-ss");
      String string = dateFormat.format(DateTime.now());
      String fileName = '$string.jpg';
      
      bool ret = false;

      try{
      response = await dio.post(url,data:{"filename": fileName});

      if(response.statusCode == HttpStatus.ok){
        Data.httpRet = true;
         Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
        print(fromJsonMap);
        
        Data.setUploadUrl(fromJsonMap);
        await upload_file(uploadUrl,fileName);


       
      }
      }
      on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
      }
      return ret;
  }

  static remote_error(DioException e){
      if (e.response != null) {
        
        print(e.response?.data);
        Data.errorMessage = '';
        Map<String,dynamic> fromJsonMap = jsonDecode(e.response.toString());
        if(fromJsonMap['errorCode'] == 400 || fromJsonMap['errorCode'] == 0){
          print(fromJsonMap['errors']);
          Data.errorMessage = fromJsonMap['message'];
        }

      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        
      }

  }
  static  upload_file(String uoloadUrl,String fileName)async{

    final options = BaseOptions(
      //baseUrl: url,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers:{
         
            "Content-Type": "image/jpeg",
         
          },
        );
        final bytes = io.File(uoloadUrl).readAsBytesSync();

      Data.httpRet = false;
      try{
        final dio = Dio(options);
    final response =  await dio.put(
  Data.presignedUrl,
  data: bytes, // Creates a Stream<List<int>>.
  options: Options(
    headers: {
      Headers.contentLengthHeader: bytes.length, // Set the content-length.
       "Content-Type": "image/jpeg",
    },
  ),
);
 
        //final response = await dio.put(Data.presignedUrl, data: formData);
        if(response.statusCode == HttpStatus.ok){
          Data.httpRet = true;
           await upload(fileName);
           
        }
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
        remote_error(e);
      }
      
  }
  static upload(String fileName)async{
    String url = "$BaseUrl/media/upload";
    print('upload $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;

      Map<String,dynamic> data = {"files": [{"path":Data.url_key,"filename":fileName}]};
      Data.httpRet = false;
      try{
      response = await dio.post(url,data:data);

      if(response.statusCode == HttpStatus.ok){
        Data.httpRet = false;
       if(Data.runFunc == 'started'){
        await started(response.data[0]);
        }
        else if(Data.runFunc == 'passed'){
          await passed(response.data[0]);

        }
        else if(Data.runFunc == 'finished'){
          await finished(response.data[0]);

        }        
        else if(Data.runFunc == 'storage'){
          Data.arttach = response.data[0];
          Data.httpRet = true;

        }   
        else if(Data.runFunc == 'product'){
          Data.arttach = response.data[0];
          Data.httpRet = true;

        }   
        //Data.httpRet = true;
        //Data.setUploadUrl(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      remote_error(e);
    }
     
  }  

  static started(String arttach)async{
    String url = "$BaseUrl/admin/transport-orders/${Data.transport_id}/started";
    print('started $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
             "Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3"
          },
        );
        final dio = Dio(options);
     
      Response response;
      
      Map<String,dynamic> data = {"lat": 24.7791656, "lng": 121.0024267};

      if(!arttach.isEmpty){
        data["attachment"] = arttach;
      }
      
      if(!Data.tmp_note.isEmpty){
        data["note"] = Data.tmp_note;
      }
      if(!Data.tmp_value.isEmpty){
        data["initial"] = Data.tmp_value;
      }
      
      
      print(data);
      Data.httpRet = false;
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       
        Data.httpRet = true;
        await GetTransportOrders();
        await getTransportCurrent();
        
      
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
    
  }  

  static passed(String arttach)async{
    String url = "$BaseUrl/admin/lots/barcode/${Data.lot_barcode}/passed";
    print('passed $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
     Data.httpRet = false;
      Response response;
    
      Map<String,dynamic> data = {"attachment": arttach};
     
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
        Data.httpRet = true;
        await getLotStatus(Data.lot_barcode);
        getTransportCurrent();
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      remote_error(e);
    }
      //return response;
  }  
  static finished(String arttach)async{
    String url = "$BaseUrl/admin/transport-orders/${Data.current.id}/finished";
    print('finished $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
     Data.httpRet = false;
      Response response;
    
      Map<String,dynamic> data = {"lat": 24.7791656, "lng": 121.0024267};
      if(!arttach.isEmpty){
        data["attachment"] = arttach;
      }
      
      data["final_odometer"] = double.tryParse(Data.tmp_value) ?? 0;

      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        await getLotStatus(Data.lot_barcode);
        getTransportCurrent();
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
        remote_error(e);
    }
      //return response;
  }  

  static updatEodometer(int isgmap,double start,double end,String note)async{
    String url = "$BaseUrl/admin/transport-orders/${Data.current.id}";
    print('finished $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
     Data.httpRet = false;
      Response response;
    
      //Map<String,dynamic> data = {"final_odometer": end, "initial_odometer": start, "note": note};
      Map<String,dynamic> data = {"note": note};
      if(isgmap == 0){
        data["final_odometer"] = end;
        data["initial_odometer"] = start;
      }

      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
        await getTransportCurrent();
       Data.httpRet = true;
       
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      //return response;
  }  
  static updateLot(String barcode,Map<String,dynamic> data)async{
    String url = "$BaseUrl/admin/lots/barcode/$barcode";
    print('updateLot $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      Data.httpRet = false;
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('updateLot1');
        print(fromJsonMap);
        Data.setTransportLotStatus(fromJsonMap);
       
        //Data.setUploadUrl(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
    
  }  
  static updateLotWeight(String barcode,Map<String,dynamic> data)async{
    String url = "$BaseUrl/admin/lots/barcode/$barcode/update";
    print('updateLotWeight $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
      Response response;
    
      Data.httpRet = false;
      try{
        //print(data);
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('updateLotWeight');
        print(fromJsonMap);
        Data.setTransportLotStatus(fromJsonMap);
       
        //Data.setUploadUrl(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
    
  }  

  static Request()async{
    String url = "$BaseUrl/admin/transport-orders/${Data.current.id}/requested";
    print('profile $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
     Data.httpRet = false;
      Response response;
      var data = {"lat": 24.7911418, "lng": 120.9658681};

      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('updateLot');
        await getTransportCurrent();
        //print(fromJsonMap);
        //Data.setTransportLotStatus(fromJsonMap);

        //Data.setUploadUrl(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      
  }  
  static Returned()async{
    String url = "$BaseUrl/admin/transport-orders/${Data.current.id}/returned";
    print('profile $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers:{
           "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Data.token.access_token}",
          },
        );
        final dio = Dio(options);
     
     Data.httpRet = false;
      Response response;
      var data = {"lat": 24.7911418, "lng": 120.9658681};
      bool ret = false;
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('updateLot');
        await getTransportCurrent();
        //print(fromJsonMap);
        //Data.setTransportLotStatus(fromJsonMap);
        ret = true;
        //Data.setUploadUrl(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());
      }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      
      remote_error(e);
    }
      return ret;
  }  
  

 }