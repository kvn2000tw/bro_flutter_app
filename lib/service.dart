import 'dart:io';

import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_util.dart';
import 'package:bro_flutter_app/transport_order_info/transport_order_info.dart';
import 'package:dio/dio.dart';
import 'dart:io' as io;
class Service{
  //static final dio = Dio();
  static const BaseUrl = 'https://recycle-server.realco2tech.com/api/app';
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
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
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

  static getTransportLotInfo()async {
    
    String url = "$BaseUrl/admin/warehouse/lots/barcode/${Data.lot_barcode}";
    print('getTransportLotInfo $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
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
        print(fromJsonMap);
        Data.setTransportLotInfo(fromJsonMap);
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
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
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
    
    String url = "$BaseUrl/admin/warehouse/lots/barcode/${Data.lotInfo.barcode}";
    print('updateLotInfo $url');
    // Or create `Dio` with a `BaseOptions` instance.
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
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
      Map<String,dynamic> data = {"note": note, "weight": weight};
      if(Data.arttach != ''){
        data["attachments"] = [Data.arttach];
        data["warehouse_id"] = warehouse;
      }
     response = await dio.put(url,data:data);
     if(response.statusCode == HttpStatus.ok){
      // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
   
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
    String url = '$BaseUrl/admin/lots/barcode/${barcode}';
    print('getLotStatus $url');
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
         Map<String,dynamic> fromJsonMap = await jsonDecode(response.toString());
         print('getLotStatus');
        //print(fromJsonMap);
        Data.setTransportLotStatus(fromJsonMap);
      }
      //print(response.statusCode.toString()); 
      //print(response.data.toString());

      return response;
  }
  static GetTransportOrders()async{

    String url = '$BaseUrl/admin/warehouse/lots/index?page=${Data.page}';
    if(Data.user.roles.contains('driver')){
      url = '$BaseUrl/admin/transport-orders/index?page=${Data.page}';
    }
    print('GetTransportOrders $url');
    // Or create `Dio` with a `BaseOptions` instance.
    
    List<Map<String,dynamic>> sorts = [];
    if(Data.sort == 1){
      sorts = [{"field":"updated_at","order":"desc","label":"最新","selected":true}];
    }
    else if(Data.sort == 2){
      sorts = [{"field":"updated_at","order":"asc","label":"最舊","selected":true}];
    }
   
   List<Map<String,dynamic>> filters = [];

   if(Data.search != ""){
    filters.add({"field":"custom_id","value":Data.search});
   }

    List<Map<String,dynamic>> value = [];
    for(var i=0;i<Data.filter.length;i++){
      if(Data.filter[i].value == true){
        value.add( {"field":"status","operator":"=","value":(i+1)});
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
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
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
    
      response = await dio.post(url,data:data);

      if(response.statusCode == HttpStatus.ok){
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
        if(fromJsonMap['errorCode'] == 400){
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
    print('profile $url');
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

      Map<String,dynamic> data = {"files": [{"path":Data.url_key,"filename":fileName}]};
      Data.httpRet = false;
      try{
      response = await dio.post(url,data:data);

      if(response.statusCode == HttpStatus.ok){
        Data.httpRet = true;
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

        }        

        Data.httpRet = true;
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
    print('profile $url');
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
    
      Map<String,dynamic> data = {"attachment": arttach, "lat": 24.7791656, "lng": 121.0024267};
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
    
      Map<String,dynamic> data = {"attachment": arttach, "lat": 24.7791656, "lng": 121.0024267};

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

  static updatEodometer(double start,double end,String note)async{
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
      Map<String,dynamic> data = {"final_odometer": end, "initial_odometer": start, "note": note};


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
    print('profile $url');
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
    
      Data.httpRet = false;
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('updateLot');
        //print(fromJsonMap);
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
    print('profile $url');
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
    
      Data.httpRet = false;
      try{
      response = await dio.put(url,data:data);

      if(response.statusCode == HttpStatus.ok){
       Data.httpRet = true;
        Map<String,dynamic> fromJsonMap = jsonDecode(response.toString());
        print('updateLot');
        //print(fromJsonMap);
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
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
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
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
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