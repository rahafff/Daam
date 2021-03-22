import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/HtmlBodyModel.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
import 'package:rxdart/rxdart.dart';

class PrivacyPolicyBloc extends BaseBloc{


  static final PrivacyPolicyBloc _instance = PrivacyPolicyBloc._internal();
  PrivacyPolicyBloc._internal();

  factory PrivacyPolicyBloc(){
    return _instance;
  }

  // ignore: close_sinks
  BehaviorSubject<HtmlBodyModel> _privacyPolicyController = BehaviorSubject<HtmlBodyModel>();
  Stream<HtmlBodyModel> get privacyPolicyStream => _privacyPolicyController.stream;


  getPrivacyPolicy(){
    fetchData(apiProvider.getPrivacyPolicy(), (data) {
      _privacyPolicyController.sink.add(data);
    }, (error) { });

  }
  // ignore: close_sinks
  BehaviorSubject<HtmlBodyModel> _termsOfServiceController = BehaviorSubject<HtmlBodyModel>();
  Stream<HtmlBodyModel> get termsOfServiceStream => _termsOfServiceController.stream;


  getTermsOfService(){
    fetchData(apiProvider.getTermsOfService(), (data) {
      _termsOfServiceController.sink.add(data);
    }, (error) { });

  }
}