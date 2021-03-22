import 'package:first_card_project/Bloc/FaqBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/FaqModel.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

import 'BaseUI.dart';

// FAQ page
class FAQ extends BaseUI<FaqBloc> {
  @override
  _FAQState createState() => _FAQState();

  FAQ():super(bloc:FaqBloc());

}

class _FAQState extends BaseUIState<FAQ> {
  FaqBloc _bloc ;

  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context,AppLocalizations.of(context).trans("faq"));
  }

  @override
  Widget buildUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constrains) {
        return StreamBuilder<FaqModel>(
            stream: _bloc.faqStream,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data.data == null)
                {
                  return helper.empty(context);
                }
              if(snapshot.hasData)
                return Container(
                  width: constrains.maxWidth,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                    /*  if(snapshot.data.data.length == index)
                      {
                        if(_bloc.canLoad)
                        {
                          _bloc.f_loadMore();
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else return Container();
                      }*/
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0 ,horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                              Text((index+1).toString() , style: AppTextStyle.largeWhiteBold,)
                              ],
                            ),
                            Container(
                              width:width*0.8,
                              //color: AppColors.white,
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(child: Text(snapshot.data.data[index].question
                                        , style: AppTextStyle.mediumCyanBold,textAlign: TextAlign.center,)),
                                    //  Image.asset("assets/images/vertical_logo.png",width: 35,height: 80,fit: BoxFit.fill,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width:width*0.8,
                                  //color: AppColors.white,
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(child: Text(snapshot.data.data[index].answer , style: AppTextStyle.mediumCyanBold,textAlign: TextAlign.center,)),
                                         // Image.asset("assets/images/vertical_logo.png",width: 35,height: 80,fit: BoxFit.fill,),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: AppColors.white,
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.data.length+0,padding: const EdgeInsets.only(top: 16 , bottom: 16),
                  ),
                );
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        );
      },
    );
  }

  @override
  void init() {
    _bloc  = widget.bloc;
    _bloc.getFaq();
  }

  @override
  void retry() {
    _bloc.getFaq();
  }
}
