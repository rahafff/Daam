import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/CouponHistoryModel.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Models/History.dart';
import 'package:first_card_project/Models/NearestServiceProvidersModel.dart';
import 'package:first_card_project/Models/ServiceProviderDetailsModel.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class ServiceProvidersBloc extends BaseBloc{

  // ignore: close_sinks
  PublishSubject<ServiceProvidersModel> _serviceProviderController = PublishSubject<ServiceProvidersModel>();
  Stream<ServiceProvidersModel> get servicesStream => _serviceProviderController.stream;
  // ignore: close_sinks
  PublishSubject<ServiceProvidersModel> _searchServiceProviderController = PublishSubject<ServiceProvidersModel>();
  Stream<ServiceProvidersModel> get searchServicesStream => _searchServiceProviderController.stream;
  // ignore: close_sinks
  PublishSubject<ServiceProviderDetailsModel> _serviceProviderDetailsController = PublishSubject<ServiceProviderDetailsModel>();
  Stream<ServiceProviderDetailsModel> get servicesDetailsStream => _serviceProviderDetailsController.stream;
  // ignore: close_sinks
  PublishSubject<History> _historyController = PublishSubject<History>();
  Stream<History> get historyStream => _historyController.stream;


  // ignore: close_sinks
  PublishSubject<CouponHistoryModel> _couponHistoryController = PublishSubject<CouponHistoryModel>();
  Stream<CouponHistoryModel> get couponHistoryStream => _couponHistoryController.stream;



// ignore: close_sinks
  PublishSubject<NearestServiceProvidersModel> _nearestServiceProvidersController = PublishSubject<NearestServiceProvidersModel>();
  Stream<NearestServiceProvidersModel> get nearestServiceProvidersStream => _nearestServiceProvidersController.stream;


  ServiceProvidersModel _data;


  int limit = 10;
  int offset = 0;
  bool canLoad = true;

  getServices({cityId, networkId, businessTypeId}){
    _serviceProviderController.sink.add(null);
    apiProvider.getServiceProviders(0, limit, cityId, networkId, businessTypeId).then((value) {
      offset = 0;
      _data = value;
      if(_data.data != null && _data.data.isNotEmpty) canLoad = true;
      else canLoad = false;
      _serviceProviderController.sink.add(value);
    }).catchError((error){

    });
  }
  getServiceProvider({providerId}){
    apiProvider.getServiceProvidersDetails(providerId).then((value) {
     _serviceProviderDetailsController.sink.add(value);
    });
    // catchError((error){
    //   print("errrrrrrorrrr");
    //   print(error);
    // });
  }

  loadMore({cityId, networkId, businessTypeId}){
    if(!canLoad) return;
    canLoad = false;
    int page = offset +limit;
    apiProvider.getServiceProviders(page, limit, cityId, networkId, businessTypeId).then((value) {
      if(value.data != null && value.data.isNotEmpty)
        {
          offset = page;
          _data.data.addAll(value.data);
          canLoad = true;
        }
      _serviceProviderController.sink.add(_data);

    }).catchError((error){

    });
  }
  
  addRate({serviceProviderId, rate,onData,onError}){
    apiProvider.addRate(serviceProviderId, rate).then((value) {
      if(value.code == 200)
        onData();
      else onError(value.message);
    }).catchError((error){
      onError("");
    });
  }

  getHistory(){
    _couponHistoryController.sink.add(null);
    fetchData<History>(apiProvider.getHistory(), (data) {
      _historyController.sink.add(data);
    }, (error) {

    });
  }
  getCouponHistory(){
    _historyController.sink.add(null);
    fetchData<CouponHistoryModel>(apiProvider.getCouponHistory(), (data) {
      _couponHistoryController.sink.add(data);
    }, (error) {

    });
  }

  Position pos;
  getNearestServiceProviders()async{
    Geolocator.getCurrentPosition().then((value) {
      pos = value;
      fetchData(apiProvider.getNearestServiceProviders(value?.longitude??0.0, value?.latitude??0.0), (data) {
        _nearestServiceProvidersController.sink.add(data);
      }, (error) {

      });
      //return;
    });
  }
  joinUsAsServiceProvider({cityId, networkId, businessTypeId, name, businessName, email, phoneNumber, password, location, longitude, latitude, description,Function(GeneralModel) onData}){
    apiProvider.joinUsAsServiceProvider(cityId, networkId, businessTypeId, name, businessName, email, phoneNumber, password, location, longitude, latitude, description).then((value) {
      onData(value);
    }).catchError((error){

    });
  }

  bool isSearching = false;
  searchServiceProviders(name){
    if(isSearching) return;
    isSearching = true;
    _searchServiceProviderController.sink.add(null);
    fetchData(apiProvider.searchServiceProviders(name), (data) {
      isSearching = false;
      _searchServiceProviderController.sink.add(data);
    }, (error) {
      isSearching = false;
    });
  }
}