//import 'package:rxdart/rxdart.dart';
import 'dart:convert';

import 'package:first_card_project/Models/BusinessTypeModel.dart';
import 'package:first_card_project/Models/CitiesModel.dart';
import 'package:first_card_project/Models/NetworksModel.dart';
import 'package:first_card_project/Models/SocialLinksModel.dart';
import 'package:first_card_project/Models/rateResponse.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:first_card_project/UI/Home.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../DataStore.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  factory SingletonBloc() {
    return _singletonBloc;
  }


  // ignore: close_sinks
  BehaviorSubject<String> _langController = BehaviorSubject<String>();
  Stream get langStream => _langController.stream;


  // ignore: close_sinks
  BehaviorSubject<CitiesModel> _citiesController = BehaviorSubject<CitiesModel>();
  Stream get citiesStream => _citiesController.stream;

  // ignore: close_sinks
  PublishSubject<BusinessTypeModel> _businessTypeController = PublishSubject<BusinessTypeModel>();
  Stream get businessTypeStream => _businessTypeController.stream;

  // ignore: close_sinks
  BehaviorSubject<NetworkModel> _networksController = BehaviorSubject<NetworkModel>();
  Stream get networksStream => _networksController.stream;

  // ignore: close_sinks
  BehaviorSubject<SocialLinksModel> _socialController = BehaviorSubject<SocialLinksModel>();
  Stream<SocialLinksModel> get socialStream => _socialController.stream;

  BehaviorSubject<RateResponse> _reController = BehaviorSubject<RateResponse>();
  Stream<RateResponse> get reStream => _reController.stream;

  GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  logout(){
    dataStore.setUser(null).then((value) {
      navigatorKey.currentState.pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => Home()
      ),(route){
        return false;
      });
    });
  }

  f_changeLang(String lang){
    dataStore.setLang(lang);
    _langController.sink.add(lang);
    // if(dataStore.user!= null)
    //   apiProvider.getUserDetails().then((value) {
    //     if(value.code >= 0){
    //       dataStore.setUser(value);
    //     }
    //   });
  }

  f_getCities(){
    apiProvider.getCities().then((value) {
      _citiesController.sink.add(value);
    },onError: (error){

    });
  }

  f_getNetworks(){
    apiProvider.getNetworks().then((value) {
      _networksController.sink.add(value);
    },onError: (error){

    });
  }
  f_getBusiness(networkId){
    apiProvider.getBusiness(networkId).then((value) {
      _businessTypeController.sink.add(value);
    },onError: (error){

    });
  }
  refreshBusiness(){
    _businessTypeController.sink.add(null);
  }

  sendMsg({name,email,phone,subject,message,onData}){
    apiProvider.sendContactUs(name, email, phone, subject, message).then((value) {
      onData(value);
    }).catchError((error){

    });
  }


  getSocialLinks(){
    _socialController.sink.add(null);
    apiProvider.getSocialLinks().then((value) {
      _socialController.sink.add(value);
    }).catchError((error){

    });
  }

  updateToken(token){
    if(dataStore.user != null && !dataStore.user.data.isProvider)
      apiProvider.changeFirebaseToken(token);
  }
  updateTokenProvider(token){
    if(dataStore.user != null && dataStore.user.data.isProvider)
      apiProvider.changeFirebaseProviderToken(token);
  }

  scanCode(serialNumber, value , Function(RateResponse) onData , Function(String)onError){
    apiProvider.scanCode(serialNumber, value).
    then((value){
      print("value in scand" + value.code.toString());
      if(value.code > 0){
        print('success');
        onData(RateResponse.fromJson(value.data));
      }
      else onError(value.message);
    }).catchError((error){
      print(error);
      onError(null);
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
  scanCouponCode(serialNumber,couponID, value ,Function(RateResponse) onData ,Function(String) onError){
    apiProvider.scanCouponCode(serialNumber,couponID, value).
    then((value){
      if(value.code >0)
      onData(RateResponse.fromJson(value.data));
      else onError(value.message);
    }).catchError((error){
      onError(null);
    });
  }
  SingletonBloc._internal();

}

final genBloc = SingletonBloc();