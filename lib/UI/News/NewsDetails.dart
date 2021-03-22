import 'package:first_card_project/Bloc/NewsBloc.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/NewsModel.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:flutter/material.dart';

import '../../Widget/HelperWigets.dart';
class NewsDetails extends BaseUI<NewsBloc> {

  String id;
  @override
  _NewsDetailsState createState() => _NewsDetailsState();

  NewsDetails({this.id}):super(bloc:NewsBloc());

}

class _NewsDetailsState extends BaseUIState<NewsDetails> {
  @override
  Widget buildUI(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return StreamBuilder<News>(
        stream: widget.bloc.newsDetailsStream,
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: height * 0.3,
                  width: width,
                  child: Image.network(
                    AppConstant.IMAGE_URL + (snapshot.data.photo != null ? snapshot.data.photo : '')
                    //"https://img.freepik.com/free-vector/breaking-news-live-world-map-connection_41981-1139.jpg?size=626&ext=jpg"
                    ,fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8 , vertical:4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.data.title , style: AppTextStyle.normalWhiteBold, textAlign: TextAlign.center,),
                      SizedBox(height: 8,),
                      Text(snapshot.data.body , style: AppTextStyle.mediumWhiteBold,),
                      SizedBox(height: 16,),

                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  @override
  void init() {
    widget.bloc.getNewsDetails(widget.id);
  }

  @override
  AppBar buildAppBar() {
    // TODO: implement buildAppBar
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("newsDetails"));
  }

  @override
  void retry() {

    widget.bloc.getNewsDetails(widget.id);
  }

}