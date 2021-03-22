import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Models/NewsModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:first_card_project/Resources/ApiProvider.dart';
class NewsBloc extends BaseBloc{

  // ignore: close_sinks
  PublishSubject<NewsModel> _newsController = PublishSubject<NewsModel>();
  Stream<NewsModel> get newsStream => _newsController.stream;
  // ignore: close_sinks
  PublishSubject<News> _newsDetailsController = PublishSubject<News>();
  Stream<News> get newsDetailsStream => _newsDetailsController.stream;

  getNews(){
    fetchData(apiProvider.getNews(), (data) {
      if((data as NewsModel).message == "Success") {
        _newsController.sink.add(data);
      }
    }, (error) {

    });
  }
  getNewsDetails(id){
    fetchData<SingleNews>(apiProvider.getNewsDetails(id), (data) {
      //if((data as NewsModel).message == "Success") {
        _newsDetailsController.sink.add(data.data);
    //  }
    }, (error) {

    });
  }

}