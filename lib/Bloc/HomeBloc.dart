import 'dart:ffi';

import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Models/Home/ImageSlider.dart';
import 'package:first_card_project/Models/UserActiveCard.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:rxdart/rxdart.dart';
class HomeBloc extends BaseBloc{


  static HomeBloc _instance = HomeBloc._internal();

  HomeBloc._internal();


  factory HomeBloc(){
    return _instance;
  }
  // ignore: close_sinks
  BehaviorSubject<ImageSliderModel> _imageSliderController = BehaviorSubject<ImageSliderModel>();
  Stream<ImageSliderModel>  get  imageSliderStream=> _imageSliderController.stream;
  // ignore: close_sinks
  BehaviorSubject<UserActiveCardModel> _userCardController = BehaviorSubject<UserActiveCardModel>();
  Stream<UserActiveCardModel>  get  userCardStream=> _userCardController.stream;


  getImageSlider(){
    apiProvider.getImages().then((value) {
      AppConstant.IMAGE_URL = value.link??AppConstant.IMAGE_URL;
      _imageSliderController.sink.add(value);
    } , onError: (error){

    });
  }
  getMyCard(){
    if(dataStore.user == null || dataStore.user.data.isProvider) return;
    _userCardController.sink.add(null);
    apiProvider.getUserActiveCard().then((value) {
      _userCardController.sink.add(value);
    }).catchError((error){
      _userCardController.sink.addError("error");
    });
  }

  refreshHome(){
    _userCardController.sink.add(null);
  }
}