import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:flutter/material.dart';

import '../DataStore.dart';
import 'SignIn.dart';
import 'SignUp.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _topPadding = MediaQuery
        .of(context)
        .padding
        .top;
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: Padding(
        padding: EdgeInsets.only(
          top: _topPadding,
        ),
        child: Stack(
          children: <Widget>[
            //helper.background(context, hasTop: false),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: _height - _topPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: GestureDetector(
                          onTap: () {
                            genBloc.f_changeLang(
                                dataStore.lang == 'ar' ? 'en' : 'ar');
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                dataStore.lang.toUpperCase(),
                                style: AppTextStyle.mediumBlack,
                              ),
                             /* Image.asset(
                                'assets/images/polygon2.png',
                                height: 15,
                                width: 15,
                                //color: Colors.blue,
                              ),
                              SizedBox(width: 4,),
                              Image.asset(
                                'assets/images/polygon1.png',
                                height: 15,
                                width: 15,
                                //color: Colors.blue,
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.35,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width * 0.35,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).trans(
                            "manageYourSocialMedia"),
                        style: AppTextStyle.largeBlack.copyWith(
                            fontFamily: AppTextStyle.cairo),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: _height * 0.07,),
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.46,
                            child: CustomAppButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                AppLocalizations.of(context).trans("login"),
                                style: AppTextStyle.mediumWhite,
                                textAlign: TextAlign.center,
                              ),
                              borderRadius: 50,
                              color: AppColors.orange,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => SignIn()
                                  )
                                );
                              },
                              elevation: 1,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.46,
                            child: CustomAppButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                AppLocalizations.of(context).trans("signUp"),
                                style: AppTextStyle.mediumWhite,
                                textAlign: TextAlign.center,
                              ),
                              borderRadius: 50,
                              color: AppColors.orange,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUp()));
                              },
                              elevation: 1,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            AppLocalizations.of(context).trans("privacyTerms"),
                            style: AppTextStyle.mediumBlue,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
