
import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Models/BusinessTypeModel.dart';
import 'package:first_card_project/Models/CardsModel.dart';
import 'package:first_card_project/Models/CitiesModel.dart';
import 'package:first_card_project/Models/CouponHistoryModel.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/Models/FaqModel.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Models/History.dart';
import 'package:first_card_project/Models/Home/ImageSlider.dart';
import 'package:first_card_project/Models/HtmlBodyModel.dart';
import 'package:first_card_project/Models/NearestServiceProvidersModel.dart';
import 'package:first_card_project/Models/NetworksModel.dart';
import 'package:first_card_project/Models/NewsModel.dart';
import 'package:first_card_project/Models/SalesCenters.dart';
import 'package:first_card_project/Models/SerialNumbersModel.dart';
import 'package:first_card_project/Models/ServiceProviderDetailsModel.dart';
import 'package:first_card_project/Models/ServiceProviderUser.dart';
import 'package:first_card_project/Models/SocialLinksModel.dart';
import 'package:first_card_project/Models/User.dart';
import 'package:first_card_project/Models/UserActiveCard.dart';
import 'package:first_card_project/Models/UserCouponHistoryModel.dart';
import 'package:first_card_project/Models/UserDetails.dart';
import 'package:first_card_project/Models/UserHistory.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/Resources/API.dart';
import 'package:http/http.dart' as http;
import '../DataStore.dart';
import 'AppMsg.dart';

enum ReqType{
  GET,POST,DIO
}
class ApiProvider{

  Dio dio ;


  ApiProvider(){
    dio = Dio();
    dio.interceptors.add(LogInterceptor(

    ));
  }

  Future<dynamic> _loadData(ReqType type,String url, {dynamic body,Map<String,String> customHeader,Map<String, dynamic> queryParameters,bool withMessage = false }) async {
    if(body == null) body = <String,String>{};
    print(url);
    var response;
    try {
      if(type == ReqType.GET )
        response = await _GetRequest(url, header: customHeader,queryParameters: queryParameters);
      else if (type == ReqType.POST)
        response = await _PostRequest(url, body, header: customHeader,queryParameters: queryParameters);
      else
        response = await _dioRequest(url, body , header: customHeader,queryParameters: queryParameters);
    }
    catch(e){
      print("error  1" + e.toString());
      throw e;
    }
    print(response.statusCode);
    if(response.statusCode == 401)
    {
      throw AppMsg(code: 401 , data: "notAuth");
    }
    // else if (response.statusCode >=200 && response.statusCode <300) {
    print("done");
    var responseBody;
    if(type == ReqType.DIO)
    {
      print(response.data);
      responseBody = json.decode(response.data);
    }
    else {
      responseBody = json.decode(response.body);
      print(response.body.toString());
    }
    print(responseBody);
   if(response.statusCode >=200 && response.statusCode <300){

     if(responseBody["code"] == -401) {
       print("sadasdasdasdasdasdasdasdas");
       print(responseBody);
       genBloc.logout();
        throw AppMsg(code: 401, data: "notAuth");
      }
      return responseBody;
   }
    else{
      throw AppMsg(
          data: responseBody.toString(),
          code: response.statusCode
      );
    }
    //}
  }

  _GetRequest(String url, {Map<String, String> header , Map<String, String> queryParameters}) async {
    if (header == null)
      header = {
//        "Accept": "application/json",
//        "Lang": dataStore.lang,
        //"Authorization":dataStore.user == null ? '' :"Bearer "+dataStore.user.tokenInfo.accessToken
        //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWF4LmFwcHMuY29kZXJzZGMuY29tXC9hcGlcL3NvY2lhbExvZ2luIiwiaWF0IjoxNTg1NDIzNDc0LCJleHAiOjE1OTA2MDc0NzQsIm5iZiI6MTU4NTQyMzQ3NCwianRpIjoibENwQTBBbk1Ddk9BTk9EcCIsInN1YiI6MywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSIsInVzZXJfaWQiOjMsImVtYWlsIjoibW91YXouYWxraG9seS4xOTk1QGdtYWlsLmNvbSJ9.b_kNAZJZRaz34BWNut1XeMRbSv4MYpzSLhvjgAyMaKs"
      };
    print('headers: ${json.encode(header)}');
    print("params: ${json.encode(queryParameters)}");
    var uri = Uri.parse(url);
    if(queryParameters != null)
    {
      uri= uri.replace(queryParameters: queryParameters);
    }
    print(uri.toString());
    final response = await http.get(uri, headers: header).timeout(Duration(seconds: 30),onTimeout: (){
      throw AppMsg(
          code: -2,
          data: "timeOut"
      );
    }).catchError((error){
      throw AppMsg(
          code: -1,
          data: error
      );
    });
    print('response:-- ${response.body}');
    return response;
  }

  _PostRequest(String url, dynamic body, {Map<String, String> header , Map<String, String> queryParameters}) async {
    print('body:  ${json.encode(body)}');
    if (header == null)
      header = {
        "Accept": "application/json",
        "language": dataStore.lang??'ar',
        "Authorization":dataStore.user == null ? '' :"Bearer "+dataStore?.user?.data?.apiToken??""
        //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWF4LmFwcHMuY29kZXJzZGMuY29tXC9hcGlcL3NvY2lhbExvZ2luIiwiaWF0IjoxNTg1NDIzNDc0LCJleHAiOjE1OTA2MDc0NzQsIm5iZiI6MTU4NTQyMzQ3NCwianRpIjoibENwQTBBbk1Ddk9BTk9EcCIsInN1YiI6MywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSIsInVzZXJfaWQiOjMsImVtYWlsIjoibW91YXouYWxraG9seS4xOTk1QGdtYWlsLmNvbSJ9.b_kNAZJZRaz34BWNut1XeMRbSv4MYpzSLhvjgAyMaKs"
      };
    print('headers: ${json.encode(header)}');
    print("params: ${json.encode(queryParameters)}");
    var uri = Uri.parse(url);
    if(queryParameters != null)
    {
      uri= uri.replace(queryParameters: queryParameters);
    }
    print(uri.toString());
    final response =
    await http.post(uri, headers: header, body: body).timeout(Duration(seconds: 30),onTimeout: (){
      throw AppMsg(
          code: -2,
          data: "timeOut"
      );
    })
        .catchError((error){
      throw AppMsg(
          code: -1,
          data: error
      );
    });
    print('response:-- ${response.body}');
    return response;
  }

  _dioRequest(String url, Map body, {Map<String, String> header , Map<String, dynamic> queryParameters})async{

    Dio dio = Dio();
    print('body:  ${body.toString()}');
    if (header == null)
      header = {
        "Accept": "application/json",
        "Content-Type":"multipart/form-data",
        "language": dataStore.lang,
        "Authorization":dataStore.user == null ? '' :"Bearer "+dataStore?.user?.data?.apiToken??""
//        "Authorization":dataStore.user == null ? '' :"Bearer "+dataStore.user.tokenInfo.accessToken
        //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWF4LmFwcHMuY29kZXJzZGMuY29tXC9hcGlcL3NvY2lhbExvZ2luIiwiaWF0IjoxNTg1NDIzNDc0LCJleHAiOjE1OTA2MDc0NzQsIm5iZiI6MTU4NTQyMzQ3NCwianRpIjoibENwQTBBbk1Ddk9BTk9EcCIsInN1YiI6MywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSIsInVzZXJfaWQiOjMsImVtYWlsIjoibW91YXouYWxraG9seS4xOTk1QGdtYWlsLmNvbSJ9.b_kNAZJZRaz34BWNut1XeMRbSv4MYpzSLhvjgAyMaKs"
      };
    print('headers: ${json.encode(header)}');
    print('queryParameters: ${json.encode(queryParameters)}');

    try{
      FormData _formData = FormData.fromMap(body);
      print(_formData.files);
      final response = await dio.post(url ,data: _formData , options:Options(
          headers: header ,responseType: ResponseType.plain ),queryParameters: queryParameters );
      return response;
    }
    on DioError catch(error){
      // error.response.
      print(error.response);
      print(error.type);
      print(error.error);
      if(error.response!=null)
        return error.response;

      else {
        if(error.type == DioErrorType.CONNECT_TIMEOUT || error.type == DioErrorType.SEND_TIMEOUT || error.type == DioErrorType.RECEIVE_TIMEOUT)
          throw AppMsg(
              code: -2,
              data: error.error
          );

        throw AppMsg(
            code: -1,
            data: error.error
        );
      }
    }

  }

  _httpRequest(){


  }

  Future<CitiesModel> getCities() async{
    var response = await _loadData(ReqType.POST, API.cities, body: <String,String>{});

   return CitiesModel.fromJson(response);

  }


  Future<GeneralModel> SignUp(String name , String email,String phone , String password , int gender ,String serialNumber,int cityId) async{
    Map<String,String> body = {
      "city_id" : cityId.toString(),
      "name": name,
      "email": email,
      "phone_number": phone,
      "password": password,
      "gender": gender.toString(),
      "serial_number": serialNumber
    };

    var response = await _loadData(ReqType.POST, API.signUp , body: body);

    return GeneralModel.fromJson(response);
  }

  Future<UserModel> login(String type,String phone , String password) async{

    DeviceInfoPlugin device = DeviceInfoPlugin();
    String serial;
    if(Platform.isIOS)
    {
      IosDeviceInfo iosInfo = await device.iosInfo;
      serial = iosInfo.identifierForVendor;
    }
     else serial = (await device.androidInfo).androidId;
    // var rr = await device.androidInfo;//.then((value) => print(value.toString()));



    Map<String,String> body = {
      "email": phone,
      "password": password,
      "serial_number": serial
    };

    var response = await _loadData(ReqType.POST,type == "User"? API.login: API.loginServiceProvider, body: body);

    return UserModel.fromJson(response);
  }

  Future<ImageSliderModel> getImages() async {
    var response = await _loadData(ReqType.POST, API.slider, body: <String,String>{});

    return ImageSliderModel.fromJson(response);
  }

  Future<NetworkModel> getNetworks() async {
    var response = await _loadData(ReqType.DIO, API.networks);
    return NetworkModel.fromJson(response);
  }

  Future<NewsModel> getNews() async {
    var response = await _loadData(ReqType.DIO, API.news);
    return NewsModel.fromJson(response);
  }

  Future<FaqModel> getFaq() async {
    var response = await _loadData(ReqType.DIO, API.faq);
    return FaqModel.fromJson(response);
  }


  Future<GeneralModel> sendContactUs(name,email,phone,subject,message) async{
    Map<String,String> body = {
      "name": "$name",
      "email": "$email",
      "phone": "$phone",
      "subject": "$subject",
      "message": "$message"
    };

    var response = await _loadData(ReqType.POST,API.contactUs,body: body);

    return GeneralModel.fromJson(response);
  }

  Future<SocialLinksModel> getSocialLinks() async{

    var response = await _loadData(ReqType.DIO,API.info);

    return SocialLinksModel.fromJson(response);
  }
  Future<CardsModel> getCards() async{

    var response = await _loadData(ReqType.DIO,API.cards);

    return CardsModel.fromJson(response);
  }

  Future<CouponsModel> getCoupons(cityId, networkId, businessTypeId,reserved,offset,serviceProviderId) async{

    Map<String,String> body = {
      "offset": offset.toString(),
      "limit": "10",
      "network_id":networkId,
      "city_id":cityId,
      "business_type_id":businessTypeId,
      "reserved":reserved,
      "service_provider_id":serviceProviderId
    };
    var response = await _loadData(ReqType.POST,API.coupons,body: body);

    return CouponsModel.fromJson(response);
  }


  Future<ServiceProvidersModel> getServiceProviders(offset,limit,cityId,networkId,businessTypeId,) async{
    Map<String,String> body = {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "city_id": cityId.toString(),
      "network_id": networkId.toString(),
      "business_type_id": businessTypeId.toString()
    };
    var response = await _loadData(ReqType.POST, API.serviceProviders , body: body);

    return ServiceProvidersModel.fromJson(response);
  }
  Future<ServiceProvidersModel> searchServiceProviders(name) async{
    Map<String,String> body = {
      "search":name
    };
    var response = await _loadData(ReqType.POST, API.serviceProviderSearch , body: body);

    return ServiceProvidersModel.fromJson(response);
  }
  Future<ServiceProviderDetailsModel> getServiceProvidersDetails(providerId) async{
    Map<String,String> body = {
      "provider_id":providerId
    };
    var response = await _loadData(ReqType.POST, API.serviceProviderDetails , body: body);

    return ServiceProviderDetailsModel.fromJson(response);
  }

  Future<BusinessTypeModel> getBusiness(String networkId) async{
    Map<String,String> body = {
      "network_id":networkId
    };
    var response = await _loadData(ReqType.POST, API.businessType, body: body);

    return BusinessTypeModel.fromJson(response);

  }
  Future<GeneralModel> changeFirebaseToken(String token) async{
    Map<String,String> body = {
      "notification_token": token,
      "device_type": Platform.isAndroid?'1':'2'
    };
    var response = await _loadData(ReqType.POST, API.changeFirebaseToken, body: body);

    return GeneralModel.fromJson(response);

  }

  Future<SingleNews> getNewsDetails(id) async {

    Map<String,String> body ={
    "news_id":id.toString()
    };
    var response = await _loadData(ReqType.POST, API.newsDetails,body: body);
    return SingleNews.fromJson(response);
  }

  Future<SalesCentersModel> getSalesCenters(offset,limit,cityId) async{
    Map<String,String> body = {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "city_id": cityId.toString()
    };
    var response = await _loadData(ReqType.POST, API.salesCenter , body: body);

    return SalesCentersModel.fromJson(response);
  }

  Future<UserDetailsModel> getUserDetails() async {
    
    var response = await _loadData(ReqType.POST, API.userDetails);
    return UserDetailsModel.fromJson(response);
  }
  Future<GeneralModel> updateUserDetails({String name , String cityId , String email , String phone , String gender}) async {
    Map<String,String> body = {
      "city_id": cityId,
      "name": name,
      "email": email,
      "phone_number": phone,
      "password": "",
      "gender": gender
    };
    var response = await _loadData(ReqType.POST, API.updateUserDetails,body: body);
    return GeneralModel.fromJson(response);
  }

  Future<CardsDetailsModel> activeCard(String code ,String cardId) async {
    Map body = {
      "card_id": cardId,
      "code": code
    };

    var response = await _loadData(ReqType.POST, API.activeCard , body: body);

    return CardsDetailsModel.fromJson(response);
  }
  
  Future<SerialNumbersModel> getCardSerialNumber(cardId) async {
    Map<String,String> body = {
      "card_id":cardId
    };
    
    var response = await _loadData(ReqType.POST, API.getCardSerialNumber , body: body);
    
    return SerialNumbersModel.fromJson(response);
  }
  Future<CardsDetailsModel> getCardDetails(cardId) async {
    Map<String,String> body = {
      "card_id":cardId
    };

    var response = await _loadData(ReqType.POST, API.cardDetails , body: body);

    return CardsDetailsModel.fromJson(response);

  }

  Future<HtmlBodyModel> getPrivacyPolicy() async{

    var response = await _loadData(ReqType.POST, API.privacyPolicy);

    return HtmlBodyModel.fromJson(response);
  }
  Future<HtmlBodyModel> getTermsOfService() async{

    var response = await _loadData(ReqType.POST, API.termsOfService);

    return HtmlBodyModel.fromJson(response);
  }
  Future<GeneralModel> addRate(serviceProviderId,rate) async{

    Map body ={
      "service_provider_id" : serviceProviderId,
      "rate" : rate
    };

    var response = await _loadData(ReqType.POST, API.addRate , body: body);

    return GeneralModel.fromJson(response);
  }
  Future<GeneralModel> joinUsAsServiceProvider(cityId,networkId,businessTypeId,name,businessName,email,phoneNumber,password,
      location,longitude,latitude,description) async{

    Map body ={
      "city_id" : cityId,
      "network_id" : networkId,
      "business_type_id" : businessTypeId,
      "name": name,
      "business_name" : businessName,
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "location": location,
      "longitude": longitude,
      "latitude": latitude,
      "description": description
    };

    var response = await _loadData(ReqType.POST, API.joinUsAsServiceProvider , body: body);

    return GeneralModel.fromJson(response);
  }
  Future<GeneralModel> scanCode(serialNumber,value) async{

    Map body ={
      "serial_number": "$serialNumber",
      "value": "$value"
    };

    var response = await _loadData(ReqType.POST, API.scanCode , body: body);

    return GeneralModel.fromJson(response);
  }
  Future<GeneralModel> scanCouponCode(serialNumber,value) async{

    Map body ={
      "serial_number": "$serialNumber",
      "value": "$value"
    };

    var response = await _loadData(ReqType.POST, API.scanCouponCode , body: body);

    return GeneralModel.fromJson(response);
  }
  Future<History> getHistory() async{

    var response = await _loadData(ReqType.POST, API.getHistory);

    return History.fromJson(response);
  }

  Future<CouponHistoryModel> getCouponHistory() async{

    var response = await _loadData(ReqType.POST, API.getCouponHistory);

    return CouponHistoryModel.fromJson(response);
  }


  Future<NearestServiceProvidersModel> getNearestServiceProviders(longitude,latitude) async{

    Map body = {
      "longitude": "$longitude",
      "latitude": "$latitude"
    };

    var response = await _loadData(ReqType.POST, API.getNearestServiceProviders,body: body);

    return NearestServiceProvidersModel.fromJson(response);
  }

  Future<UserActiveCardModel> getUserActiveCard() async{

    var response = await _loadData(ReqType.POST, API.getUserActiveCard);

    return UserActiveCardModel.fromJson(response);
  }
  Future<UserHistoryModel> getUserHistory() async{

    var response = await _loadData(ReqType.POST, API.getUserHistory);

    return UserHistoryModel.fromJson(response);
  }
  Future<UserCouponHistoryModel> getUserCouponHistory() async{

    var response = await _loadData(ReqType.POST, API.getUserCouponHistory);

    return UserCouponHistoryModel.fromJson(response);
  }

  Future<SerialNumbersModel> getCouponSerialNumber(couponId) async {
    Map<String,String> body = {
      "coupon_id":couponId
    };

    var response = await _loadData(ReqType.POST, API.getCouponSerialNumber , body: body);

    return SerialNumbersModel.fromJson(response);
  }

  Future<GeneralModel> reserveCoupon(couponId) async {

    Map<String,String> body = {
      "coupon_id":couponId.toString()
    };


    var response = await _loadData(ReqType.POST, API.reserveCoupon,body: body);

    return GeneralModel.fromJson(response);
  }
  Future<CouponDetailsModel> couponDetails(couponId) async{

    Map<String,String> body = {
      "coupon_id":couponId.toString()
    };


    var response = await _loadData(ReqType.POST, API.couponDetails,body: body);

    return CouponDetailsModel.fromJson(response);
  }
}

ApiProvider apiProvider = ApiProvider();

//AIzaSyAdc_rZksdTyQ5YvGOiAVnO6nmLxRbPcf4