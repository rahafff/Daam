import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/CardsBloc.dart';
import 'package:first_card_project/Bloc/HomeBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CardsModel.dart';
import 'package:first_card_project/UI/Cards/UseCard.dart';
import 'package:first_card_project/UI/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:first_card_project/UI/PrivacyPolicy/TermOfService.dart';
import 'package:first_card_project/UI/SignIn.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../BaseUI.dart';

class CardDetails extends BaseUI<CardsBloc> {
  final CardsBloc bloc;
  final CardItem card;
  CardDetails({Key key, this.bloc,this.card}) : super(bloc: bloc);

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends BaseUIState<CardDetails> {
  bool _isLoading = false;
  bool activeCard = false;
  bool privacyRead = false;
  TextEditingController _controller = TextEditingController();
  FocusNode focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    focus.dispose();
    super.dispose();
  }


  Widget dataRow({name, value}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      name,
                      style: AppTextStyle.mediumWhite,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      value,
                      style: AppTextStyle.mediumWhiteBold,
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
        ),
        Divider(
          color: AppColors.orange,
          thickness: 1.5,
        ),
      ],
    );
  }

  @override
  AppBar buildAppBar() {
  }

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(context, widget.card.name),
      body: StreamBuilder<CardsDetailsModel>(
        stream: widget.bloc.cardDetailsStream,
        builder: (context, snapshot) {

          if(snapshot.hasData)
            return ModalProgressHUD(
              inAsyncCall: _isLoading,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                        tag: widget.card.id.toString() + "img",
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: AppConstant.IMAGE_URL + widget.card.photo,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      dataRow(
                          name: AppLocalizations.of(context).trans("name"),
                          value: widget.card.name),
                      dataRow(
                          name: AppLocalizations.of(context).trans("price"),
                          value: widget.card.price),
                      dataRow(
                          name: AppLocalizations.of(context).trans("expiry"),
                          value: widget.card.expireAt +
                              "  " +
                              AppLocalizations.of(context).trans("day")),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.card.description,
                          style: AppTextStyle.normalWhite,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      dataStore.user == null?Container(
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignIn()));
                            },
                            child: Text(AppLocalizations.of(context).trans("loginToActiveTheCard"),style: AppTextStyle.mediumWhiteBold.copyWith(
                              decoration: TextDecoration.underline
                            ),),
                          ),
                        ),
                      )
                          : dataStore.user.data.isProvider? Container() :
                      widget.card.active == "1" ? Container(
                        child: Center(
                          child: CustomAppButton(
                            child: Text(
                              AppLocalizations.of(context).trans("useCard"),
                              style: AppTextStyle.mediumWhiteBold,
                            ),
                            color: AppColors.cyan,
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => UseCard(snapshot.data.data.activeCardId.toString())
                              // ));
                            },
                            padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                            borderRadius: 20,
                            elevation: 2,
                          ),
                        ),
                      ):
                      AnimatedCrossFade(
                        duration: Duration(milliseconds: 500),
                        firstChild: Center(
                          child: CustomAppButton(
                            child: Text(
                              AppLocalizations.of(context).trans("active"),
                              style: AppTextStyle.mediumWhiteBold,
                            ),
                            color: AppColors.cyan,
                            onTap: () {
                              setState(() {
                                activeCard = true;
                              });
                              focus.requestFocus();
                            },
                            padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                            borderRadius: 20,
                            elevation: 2,
                          ),
                        ),
                        secondChild: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .trans("enterActivationCode"),
                              style: AppTextStyle.mediumWhiteBold,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              style: AppTextStyle.largeBlackBold,
                              cursorColor: AppColors.orange,
                              focusNode: focus,
                              controller: _controller,
                              decoration: InputDecoration(
                                fillColor: AppColors.white,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.all(4),
                                border: InputBorder.none,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
  //                            direction: Axis.horizontal,
  //                            crossAxisAlignment: WrapCrossAlignment.center,
  //                            mainAxisAlignment: MainAxisAlignment.center,
  //                            mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  //SizedBox(width: 8,),
                                  Checkbox(
                                      value: privacyRead,
                                      activeColor: AppColors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          privacyRead = val;
                                        });
                                      }),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .trans("read_privacy"),/*"By registering, you agree to the ",*/
                                          style: TextStyle(
                                              color: AppColors.white,
                                              height: 1.4,
                                              fontSize: MediaQuery.of(context).size.width*0.035648
                                            /*AppFonts.get_medium_font_size(
                                                    lang: AppLocalizations.of(context)
                                                        .locale
                                                        .languageCode)*/
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => PrivacyPolicyPage()
                                            ));
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .trans("privacyPolicy"),
                                            style: TextStyle(
                                                color: AppColors.white,
                                                height: 1.4,
                                                fontSize: MediaQuery.of(context).size.width*0.035648/*AppFonts.get_medium_font_size(
                                                    lang: AppLocalizations.of(context)
                                                        .locale
                                                        .languageCode)*/,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ' ${AppLocalizations.of(context).trans("and")} ',
                                          style: TextStyle(
                                              color: AppColors.white,
                                              height: 1.4,
                                              fontSize: MediaQuery.of(context).size.width*0.035648/*AppFonts.get_medium_font_size(
                                                    lang: AppLocalizations.of(context)
                                                        .locale
                                                        .languageCode)*/),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => TermsOfServicePage()
                                            ));
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .trans("termsOfService"),
                                            style: TextStyle(
                                                color: AppColors.white,
                                                height: 1.4,
                                                fontSize: MediaQuery.of(context).size.width*0.035648/*AppFonts.get_medium_font_size(
                                                      lang: AppLocalizations.of(context)
                                                          .locale
                                                          .languageCode)*/,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: CustomAppButton(
                                child: Text(
                                  AppLocalizations.of(context).trans("active"),
                                  style: AppTextStyle.mediumWhiteBold,
                                ),
                                color: !privacyRead?AppColors.gray:AppColors.cyan,
                                onTap: () {
                                  if(!privacyRead) return;
                                  if (Utils.isTextEmpty(_controller)) {
                                    showErrorDialog(
                                        context,
                                        AppLocalizations.of(context)
                                            .trans("enterActivationCode"));
                                    return;
                                  }
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  widget.bloc.activeCard(
                                      code: _controller.text,
                                      cardId: snapshot.data.data.id.toString(),
                                      onData: (val) async{
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (val.code == 200)  {
                                          HomeBloc().getMyCard();
                                          var res = await showErrorDialog(
                                              context,
                                              AppLocalizations.of(context)
                                                  .trans("successActivation"),isError: false);

                                          Navigator.of(context).popUntil((route) => route.isFirst);
                                          // setState(() {
                                          //   widget.card.active = "1";
                                          //   widget.card.activeCardId = val.data.activeCardId;
                                          // });

                                        } else
                                          showErrorDialog(context, val.message);
                                      },
                                      onError: (error) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        showErrorDialog(
                                            context,
                                            AppLocalizations.of(context)
                                                .trans("wrong"));
                                      });

  //                            setState(() {
  //                              activeCard = false;
  //                            });
                                },
                                padding:
                                EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                                borderRadius: 20,
                                elevation: 2,
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            )
                          ],
                        ),
                        crossFadeState: activeCard
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      )
                    ],
                  ),
                ),
              ),
            );

          return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  @override
  void init() {
    widget.bloc.getCardDetails(cardId: widget.card.id.toString());
  }
}
