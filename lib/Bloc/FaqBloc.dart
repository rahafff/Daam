import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/FaqModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
class FaqBloc extends BaseBloc{

  // ignore: close_sinks
  PublishSubject<FaqModel> _faqController = PublishSubject<FaqModel>();
  Stream<FaqModel> get faqStream => _faqController.stream;

  getFaq(){
    fetchData(apiProvider.getFaq(), (data) {
      if((data as FaqModel).message == "Success") {
        _faqController.sink.add(data);
      }
    }, (error) {

    });
  }

}