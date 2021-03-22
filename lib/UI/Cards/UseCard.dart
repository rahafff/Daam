import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/CardsBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/SerialNumbersModel.dart';
import 'package:first_card_project/Models/UserActiveCard.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class UseCard extends BaseUI<CardsBloc> {

  final String cardId;
  final SelectedCard card;
  @override
  _UseCardState createState() => _UseCardState();

  UseCard(this.cardId,this.card):super(bloc: CardsBloc());
}

class _UseCardState extends BaseUIState<UseCard> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("useCard"));
  }

  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<SerialNumber>(
      stream: widget.bloc.serialNumbersStream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    //color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(0)),
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: CachedNetworkImage(imageUrl:
                                  AppConstant.IMAGE_URL + widget.card.photo,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dataStore.lang == "en" ? widget.card.nameEn??"":widget.card.name,
                                  style: AppTextStyle.largeWhiteBold,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Text(snapshot.data.serialNumber , style: AppTextStyle.largeWhiteBold,),
                  SizedBox(height: 80,),
                  Text(AppLocalizations.of(context).trans("scanQR") , style: AppTextStyle.largeWhiteBold,),
                  SizedBox(height: 8,),

                  QrImage(
                    data: "${snapshot.data.serialNumber}",
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: AppColors.white,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimatedTextKit(
                    text: ["15","14","13","12","11","10","9","8","7","6","5","4","3","2","1"],
                    duration: Duration(
                      seconds: 1
                    ),
                    pause: Duration(seconds: 0),
                    textStyle: AppTextStyle.largeWhiteBold,
                    repeatForever: true,
                    onFinished: (){
                      widget.bloc.getNext(widget.cardId);
                    },
                    onNext: (index,val){
//                      print(index);
//                      print(val);
                      if(val) widget.bloc.getNext(widget.cardId);
                    },
//                    onNextBeforePause: (index,val){
//                      print("before");
//                      print(index);
//                      print(val);
//
//                    },
                  )

                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
    });
  }

  @override
  void init() {
    widget.bloc.getSerialNumbers(cardId: widget.cardId);
  }

}
