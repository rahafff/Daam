
import 'package:first_card_project/Models/CardsModel.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Models/SerialNumbersModel.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:first_card_project/Resources/AppMsg.dart';
import 'package:rxdart/rxdart.dart';

import 'BaseBloc.dart';

class CardsBloc extends BaseBloc{

  // ignore: close_sinks
  BehaviorSubject<CardsModel> _cardsModel = BehaviorSubject<CardsModel>();
  Stream<CardsModel> get cardsStream => _cardsModel.stream;
  // ignore: close_sinks
  PublishSubject<CardsDetailsModel> _cardDetailsModel = PublishSubject<CardsDetailsModel>();
  Stream<CardsDetailsModel> get cardDetailsStream => _cardDetailsModel.stream;


  // ignore: close_sinks
  PublishSubject<SerialNumber> _serialNumbersController = PublishSubject<SerialNumber>();
  Stream<SerialNumber> get serialNumbersStream => _serialNumbersController.stream;


  getCards() async {

    apiProvider.getCards().then((value) {
      _cardsModel.sink.add(value);
    } , onError: (error){});

  }

  activeCard({String cardId , String code , Function(CardsDetailsModel)onData ,Function(String) onError}){
    apiProvider.activeCard(code, cardId).then((value) {
      onData(value);
    }).catchError((error){
      print("error is" + error.toString());
      if(error is AppMsg)
      onError(error.data["message"]);
    });
  }

  SerialNumbersModel serialNumbers ;
  int index = 0;

  getSerialNumbers({String cardId}){
    fetchData(apiProvider.getCardSerialNumber(cardId), (data)  async {

      serialNumbers = data;
      _serialNumbersController.sink.add(serialNumbers.data.first);
      index =1;
//      for(int i = 1 ; i<serialNumbers.data.length ; i++){
//        await Future.delayed(Duration(seconds: 10) , (){
//          _serialNumbersController.sink.add(serialNumbers.data[i]);
//        });
//      }
    }, (error) { });
  }


  getNext(cardId){
    if(index == serialNumbers.data.length) {
      _serialNumbersController.sink.add(null);
      getSerialNumbers(cardId: cardId);
      return;
    }
    _serialNumbersController.sink.add(serialNumbers.data[index]);
    index++;

  }


  getCardDetails({String cardId}){
    fetchData(apiProvider.getCardDetails(cardId), (data) {
      _cardDetailsModel.sink.add(data);
    }, (error) { });
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

  @override
  dispose() {
    _cardsModel.close();
    _serialNumbersController.close();
    super.dispose();
  }


}