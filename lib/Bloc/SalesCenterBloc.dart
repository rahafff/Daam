//SalesCenterBloc
import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/SalesCenters.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:rxdart/rxdart.dart';

class SalesCenterBloc extends BaseBloc{

  // ignore: close_sinks
  PublishSubject<SalesCentersModel> _salesCentersController = PublishSubject<SalesCentersModel>();
  Stream<SalesCentersModel> get salesCentersStream => _salesCentersController.stream;


  int limit = 10;
  int offset = 0;
  bool canLoad = true;

  SalesCentersModel _data;
  getSalesCenters({cityId}){
    _salesCentersController.sink.add(null);


    apiProvider.getSalesCenters(0, limit, cityId).then((value) {
      offset = 0;
      _data = value;
      if(_data.data != null && _data.data.isNotEmpty) canLoad = true;
      else canLoad = false;
      _salesCentersController.sink.add(value);
    }).catchError((error){

    });
  }
  loadMore({cityId}){
    if(!canLoad) return;
    canLoad = false;
    int page = offset +limit;
    apiProvider.getSalesCenters(page, limit, cityId).then((value) {
      if(value.data != null && value.data.isNotEmpty)
      {
        offset = page;
        _data.data.addAll(value.data);
        canLoad = true;
      }
      _salesCentersController.sink.add(_data);

    }).catchError((error){

    });
  }


}