import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/NotificationHelper.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Models/UserCouponHistoryModel.dart';
import 'package:first_card_project/Models/UserDetails.dart';
import 'package:first_card_project/Models/UserHistory.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:first_card_project/UI/User/User.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:rxdart/rxdart.dart';

import 'GeneralBloc.dart';

class AuthBloc extends BaseBloc{


  // ignore: close_sinks
  PublishSubject<UserDetailsModel> _userDetailsController = PublishSubject();
  Stream<UserDetailsModel> get userDetailsStream => _userDetailsController.stream;
  // ignore: close_sinks
  PublishSubject<UserHistoryModel> _userHistoryController = PublishSubject<UserHistoryModel>();
  Stream<UserHistoryModel> get userHistoryStream => _userHistoryController.stream;
// ignore: close_sinks
  PublishSubject<UserCouponHistoryModel> _userCouponHistoryController = PublishSubject<UserCouponHistoryModel>();
  Stream<UserCouponHistoryModel> get userCouponHistoryStream => _userCouponHistoryController.stream;

  signUp({String name , String email,String phone , String password , int gender ,String serialNumber,int cityId,onData}) {

    apiProvider.SignUp(name, email, phone, password, gender, serialNumber, cityId).then((value) {
      onData(value);
    }, onError:(error){

    });
  }


  login({String type ="User" ,String phone , String password ,onData}) {
    apiProvider.login(type,phone, password).then((value) {
      onData(value);
      if(value.code == 200){
        dataStore.setUser(value).then((_) {
          //if(!value.data.isProvider)
            genBloc.updateToken(notificationHelper.token);
        });
      }
    }, onError:(error){

    });
  }


  userDetails(){
    fetchData(apiProvider.getUserDetails(), (data) {
      _userDetailsController.sink.add(data);
    }, (error) { });
  }

  updateUserDetails({String name , String email , String phone , String gender , String cityId ,Function(GeneralModel) onData}){
    apiProvider.updateUserDetails(
      cityId: cityId,
      name: name,
      email: email,
      phone: phone,
      gender: gender
    ).then((value) {
      onData(value);
    }).catchError((error){

    });
  }

  getUserHistory(){
    //_userCouponHistoryController.sink.add(null);

    fetchData<UserHistoryModel>(apiProvider.getUserHistory(), (data) {
      _userHistoryController.sink.add(data);
    }, (error) {

    });
  }
  getUserCouponHistory(){
    //_userHistoryController.sink.add(null);

    fetchData<UserCouponHistoryModel>(apiProvider.getUserCouponHistory(), (data) {
      _userCouponHistoryController.sink.add(data);
    }, (error) {

    });
  }
}