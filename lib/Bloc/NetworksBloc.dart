import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/NetworksModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
class NetworkBloc extends BaseBloc{

  // ignore: close_sinks
  PublishSubject<NetworkModel> _networkController = PublishSubject<NetworkModel>();
  Stream<NetworkModel> get networkStream => _networkController.stream;

  getNetwork(){
    fetchData(apiProvider.getNetworks(), (data) {

      if((data as NetworkModel).message == "Success") {
        _networkController.sink.add(data);
      }
    }, (error) {
    });
  }

}