import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/CardsBloc.dart';
import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/SerialNumbersModel.dart';
import 'package:first_card_project/Models/UserActiveCard.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class UseCard extends BaseUI<CardsBloc> {
  final String cardId;
  final String createAt;
  final String expireAt;
  final SelectedCard card;
  @override
  _UseCardState createState() => _UseCardState();

  UseCard(this.cardId, this.card, this.createAt, this.expireAt)
      : super(bloc: CardsBloc());
}

class _UseCardState extends BaseUIState<UseCard> {
  TextEditingController _value = TextEditingController();
  TextEditingController _qr = TextEditingController();
  bool isLoading;

  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context, AppLocalizations.of(context).trans("useCard"));
  }

  @override
  Widget buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0)),
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: CachedNetworkImage(
                            imageUrl: AppConstant.IMAGE_URL + widget.card.photo,
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
                            dataStore.lang == "en"
                                ? widget.card.nameEn ?? ""
                                : widget.card.name,
                            style: AppTextStyle.largeWhiteBold,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).trans("activeDate"),
                          style: AppTextStyle.mediumWhiteBold,
                        ),
                        subtitle: Text(
                          widget.createAt,
                          style: AppTextStyle.mediumWhite,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).trans("expireDate"),
                          style: AppTextStyle.mediumWhiteBold,
                        ),
                        subtitle: Text(
                          widget.expireAt,
                          style: AppTextStyle.mediumWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Text(snapshot.data.serialNumber , style: AppTextStyle.largeWhiteBold,),
          // SizedBox(height: 80,),
          helper.getTextField(_value, false, null, null,
              AppLocalizations.of(context).trans("pleaseEnterValue"),
              inputType: TextInputType.number),
          SizedBox(
            height: 50,
          ),
          Text(
            AppLocalizations.of(context).trans("scanQR"),
            style: AppTextStyle.largeWhiteBold,
          ),

          InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                if (Utils.isTextEmpty(_value)) {
                  showErrorDialog(context,
                      AppLocalizations.of(context).trans("pleaseEnterValue"));
                  return;
                }
                BarcodeScanner.scan().then((value) {
                  if (value.rawContent == "" || value.rawContent == null)
                    return;
                  String payload = value.rawContent;
                  print("Scan result" + payload);
                  setState(() {
                    isLoading = true;
                    if (payload != null && payload.isNotEmpty) {
                      genBloc.scanCode(payload, _value.text, (response) {
                        setState(() {
                          print('here');
                          print(response.name);
                          isLoading = false;
                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              double rate =response.rate;
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)
                                    .trans("rate") +
                                    " " +
                                    response.name),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Html(data: response.description),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: SmoothStarRating(
                                          starCount: 5,
                                          rating: rate,
                                          //allowHalfRating: false,
                                          color: AppColors.orange,
                                          borderColor: AppColors.orange,
                                          onRated: (value) {
                                            rate = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      CustomAppButton(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .trans("rate"),
                                          style: AppTextStyle.mediumWhiteBold,
                                        ),
                                        color: AppColors.cyan,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        borderRadius: 20,
                                        elevation: 2,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          genBloc.addRate(
                                              serviceProviderId:
                                              payload.toString(),
                                              rate: rate.toString(),
                                              onData: () {
                                                showErrorDialog(
                                                    context,
                                                    AppLocalizations.of(context)
                                                        .trans("ratedSuccessfully"),
                                                    isError: false);
                                                // snapshot.data.data.rate = res;

                                              },
                                              onError: (String e) {
                                                showErrorDialog(
                                                    context,
                                                    e.isEmpty
                                                        ? AppLocalizations.of(context)
                                                        .trans("wrong")
                                                        : e,
                                                    isError: true);
                                              });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }, (msg) {
                        setState(() {
                          payload = null;
                          isLoading = false;
                        });

                        if (msg != null) {
                          isLoading = false;
                          showErrorDialog(context, msg);
                        }
                      });

                      // genBloc.scanCouponCode(
                      //     qr_id,widget.card.id, _value, () {
                      //   setState(() {
                      //     // success = true;
                      //   });
                      // }, (msg) {
                      //   setState(() {
                      //     payload = null;
                      //   });
                      //   if (msg != null)
                      //     showErrorDialog(context, msg);
                      // });

                    }
                  });
                });
              },
              child: Icon(
                Icons.qr_code_scanner,
                color: AppColors.white,
                size: 200,
              )),
          Text( AppLocalizations.of(context)
              .trans("or"),style: AppTextStyle.mediumWhite,),
          SizedBox(height: 10,),
          Text( AppLocalizations.of(context)
              .trans("enterCode"),style: AppTextStyle.mediumWhite,),
          Row(
            children: [
              Expanded(
                child: helper.getTextField(_qr, false, null, null,
                    AppLocalizations.of(context).trans("enterCode"),
                    inputType: TextInputType.text),
              ),
              TextButton(onPressed: (){
                if (Utils.isTextEmpty(_value) || Utils.isTextEmpty(_qr) ) {
                  showErrorDialog(context,
                      AppLocalizations.of(context).trans("enterFiled"));
                  return;
                }
                setState(() {
                  isLoading = true;
                  if (_qr.text != null && _qr.text.isNotEmpty) {
                    genBloc.scanCode(_qr.text, _value.text, (response) {
                      setState(() {
                        print('here');
                        print(response.name);
                        isLoading = false;
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            double rate =response.rate;
                            return AlertDialog(
                              title: Text(AppLocalizations.of(context)
                                  .trans("showAlert")),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Html(data: response.description),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: SmoothStarRating(
                                        starCount: 5,
                                        rating: 0,
                                        //allowHalfRating: false,
                                        color: AppColors.orange,
                                        borderColor: AppColors.orange,
                                        onRated: (value) {
                                          rate = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    CustomAppButton(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .trans("rate"),
                                        style: AppTextStyle.mediumWhiteBold,
                                      ),
                                      color: AppColors.cyan,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      borderRadius: 20,
                                      elevation: 2,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        genBloc.addRate(
                                            serviceProviderId:
                                            _qr.text.toString(),
                                            rate: rate.toString(),
                                            onData: () {
                                              showErrorDialog(
                                                  context,
                                                  AppLocalizations.of(context)
                                                      .trans("ratedSuccessfully"),
                                                  isError: false);
                                              // snapshot.data.data.rate = res;

                                            },
                                            onError: (String e) {
                                              showErrorDialog(
                                                  context,
                                                  e.isEmpty
                                                      ? AppLocalizations.of(context)
                                                      .trans("wrong")
                                                      : e,
                                                  isError: true);
                                            });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }, (msg) {
                      setState(() {
                        _qr.text = null;
                        isLoading = false;
                      });

                      if (msg != null) {
                        isLoading = false;
                        showErrorDialog(context, msg);
                      }
                    });
                  }
                });
              }, child:   Text( AppLocalizations.of(context)
                  .trans("ok"),style: AppTextStyle.mediumWhite,),)
            ],
          ),
          SizedBox(height: 10,),


          Visibility(visible: isLoading, child: CircularProgressIndicator())

          // QrImage(
          //   data: "${snapshot.data.serialNumber}",
          //   version: QrVersions.auto,
          //   size: 200.0,
          //   backgroundColor: AppColors.white,
          // ),

//                   SizedBox(
//                     height: 30,
//                   ),
//                   FadeAnimatedTextKit(
//                     text: ["15","14","13","12","11","10","9","8","7","6","5","4","3","2","1"],
//                     duration: Duration(
//                       seconds: 1
//                     ),
//                     pause: Duration(seconds: 0),
//                     textStyle: AppTextStyle.largeWhiteBold,
//                     repeatForever: true,
//                     onFinished: (){
//                       widget.bloc.getNext(widget.cardId);
//                     },
//                     onNext: (index,val){
// //                      print(index);
// //                      print(val);
//                       if(val) widget.bloc.getNext(widget.cardId);
//                     },
// //                    onNextBeforePause: (index,val){
// //                      print("before");
// //                      print(index);
// //                      print(val);
// //
// //                    },
//                   )
        ],
      ),
    );
  }

  @override
  void init() {
    isLoading = false;
    // widget.bloc.getSerialNumbers(cardId: widget.cardId);
  }
}
