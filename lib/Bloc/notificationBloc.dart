import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/FaqModel.dart';
import 'package:first_card_project/Models/notificationModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
class NotyBloc extends BaseBloc{

  // ignore: close_sinks
  PublishSubject<NotificationModel> _faqController = PublishSubject<NotificationModel>();
  Stream<NotificationModel> get faqStream => _faqController.stream;

  getNoty(){
    fetchData(apiProvider.getNoty(), (data) {
      if((data as NotificationModel).message == "Success") {
        _faqController.sink.add(data);
      }
    }, (error) {

    });
  }

}