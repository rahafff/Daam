import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Models/SerialNumbersModel.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:rxdart/rxdart.dart';

class CouponsBloc extends BaseBloc{

  // ignore: close_sinks
  BehaviorSubject<CouponsModel> _couponsModel = BehaviorSubject<CouponsModel>();
  Stream<CouponsModel> get couponsStream => _couponsModel.stream;


  // ignore: close_sinks
  PublishSubject<SerialNumber> _serialNumbersController = PublishSubject<SerialNumber>();
  Stream<SerialNumber> get serialNumbersStream => _serialNumbersController.stream;

  // ignore: close_sinks
  PublishSubject<CouponDetailsModel> _couponDetailsController = PublishSubject<CouponDetailsModel>();
  Stream<CouponDetailsModel> get couponDetailsStream => _couponDetailsController.stream;

  int limit = 10;
  int offset = 0;
  bool canLoad = true;
  CouponsModel _data;
  getCoupons({cityId, networkId, businessTypeId,reserved,offset,serviceProviderId}) async {

    apiProvider.getCoupons(cityId, networkId, businessTypeId,reserved,offset,serviceProviderId).then((value) {

      // offset = 0;
      _data = value;
      if(_data.data != null && _data.data.isNotEmpty) canLoad = true;
      else canLoad = false;
      _couponsModel.sink.add(value);
    } ).catchError((e){});

  }

  loadMore({cityId, networkId, businessTypeId,reserved,serviceProviderId}){
    if(!canLoad) return;
    canLoad = false;
    int page = offset +limit;
    apiProvider.getCoupons(cityId, networkId, businessTypeId,reserved,page,serviceProviderId).then((value) {
      if(value.data != null && value.data.isNotEmpty)
      {
        offset = page;
        _data.data.addAll(value.data);
        canLoad = true;
      }
      _couponsModel.sink.add(_data);
    }).catchError((error){});

  }
  SerialNumbersModel serialNumbers ;
  int index = 0;

  getSerialNumbers({String couponId}){
    fetchData(apiProvider.getCouponSerialNumber(couponId), (data)  async {
      serialNumbers = data;
      _serialNumbersController.sink.add(serialNumbers.data.first);
      index =1;
    }, (error) {
      _serialNumbersController.sink.addError(error.code);
    });
  }


  getNext({String couponId}){
    if(index == serialNumbers.data.length) {
      _serialNumbersController.sink.add(null);
      getSerialNumbers(couponId: couponId);
      return;
    }
    _serialNumbersController.sink.add(serialNumbers.data[index]);
    index++;
  }


  reserveCoupon({couponId,Function(GeneralModel) onData}){
    apiProvider.reserveCoupon(couponId).then((value){
      onData(value);
    }).catchError((error){
      onData(null);
    });
  }

  update(CouponDetailsModel data){
    _couponDetailsController.sink.add(data);
  }

  getCouponDetails(couponId){
    fetchData<CouponDetailsModel>(apiProvider.couponDetails(couponId), (data) {
      _couponDetailsController.sink.add(data);
    }, (error) {

    });
  }
}