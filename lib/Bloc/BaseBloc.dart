import 'package:first_card_project/Resources/AppMsg.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc{

  PublishSubject _generalErrorsController = PublishSubject();

  Stream get errorsStream => _generalErrorsController.stream;

  PublishSubject<int> uiErrorConteroller = PublishSubject<int>();

  Stream get uiErrorsStream => uiErrorConteroller.stream;



  fetchData<T>(Future<dynamic> func, void onData(T data) , void onError(dynamic error)){
    func.then((val){
      if(val.code == 200)
      onData(val);
      else {
        _generalErrorsController.sink.add(val.message);
        onError(val);
      }
    }) .catchError((error){
      print(error.toString());
      if(error is AppMsg)
      {
       if(error.code == -1 || error.code == -2 || error.code == 401)
         {
          _generalErrorsController.sink.add(error);
         }
       else onError(error);
      }
      else {

      }
    });
  }


  dispose(){
    _generalErrorsController.close();
  }

}