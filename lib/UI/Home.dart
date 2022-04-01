import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Bloc/HomeBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/Home/ImageSlider.dart';
import 'package:first_card_project/Models/User.dart';
import 'package:first_card_project/Models/UserActiveCard.dart';
import 'package:first_card_project/UI/AboutUs.dart';
import 'package:first_card_project/UI/Cards/UseCard.dart';
import 'package:first_card_project/UI/Coupons/CouponsPage.dart';
import 'package:first_card_project/UI/NearestServiceProvider.dart';
import 'package:first_card_project/UI/NetworksPage.dart';
import 'package:first_card_project/UI/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:first_card_project/UI/PrivacyPolicy/TermOfService.dart';
import 'package:first_card_project/UI/ScanCode.dart';
import 'package:first_card_project/UI/ServiceProviders/AddServiceProvider.dart';
import 'package:first_card_project/UI/ServiceProviders/ServiceProviderHistory.dart';

//import 'package:first_card_project/UI/SalesCenters/SalesCenterPage.dart';
import 'package:first_card_project/UI/SignIn.dart';
import 'package:first_card_project/UI/SignUp.dart';
import 'package:first_card_project/UI/User/User.dart';
import 'package:first_card_project/UI/notification.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/SocialLinksWidget.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:launch_review/launch_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

import 'BaseUI.dart';
import 'Cards/CardsPage.dart';
import 'ContactUs.dart';
import 'FAQ.dart';
import 'News/NewsPage.dart';

//import 'SalesCenters/SalesCenterPage.dart';
import 'SalesCenters/SalesCentersPage.dart';
import 'ServiceProviders/ServiceProvidersPage.dart';
import 'User/UserHistory.dart';

class Home extends BaseUI<HomeBloc> {
  @override
  _HomeState createState() => _HomeState();

  Home() : super(bloc: HomeBloc());
}

class _HomeState extends BaseUIState<Home> {
  PackageInfo packageInfo;

  @override
  AppBar buildAppBar() {
//    return AppBar(
//      backgroundColor: AppColors.orange,
//      elevation: 0,
//    );

    return null;
  }

  @override
  Widget buildUI(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double cardHeight = (MediaQuery.of(context).size.width - 32) * 0.5;
    double singleCardHeight = MediaQuery.of(context).size.width * 0.4;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        isFirstTime().then((isFirstTime) {
          isFirstTime
              ? showDialog(
              context: context,
              builder: (BuildContext context) {
               return AlertDialog(
                  title: Text(AppLocalizations.of(context).trans('rateThis')),
                  content:
                      Text(AppLocalizations.of(context).trans('rateContent')),
                  actions: [
                    TextButton(
                        onPressed: () {
                         Utils.lunchURL("https://play.google.com/store/apps/details?id=" +  packageInfo.packageName);
                        },
                        child:
                            Text(AppLocalizations.of(context).trans('rate'))),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                            AppLocalizations.of(context).trans('noThanks'))),
                  ],
                );})
              : exit(-1);
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.lightBlack,
          title: Text(
            AppLocalizations.of(context).trans("home"),
            style: AppTextStyle.normalWhiteBold.copyWith(
                fontWeight: FontWeight.bold /*,color: AppColors.orange*/),
          ),
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
            child: Container(
              color: AppColors.lightBlack,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/logo.png",
                          /* width: MediaQuery.of(context).size.width*0.2,*/
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      AppLocalizations.of(context).trans("daamCard"),
                      style: AppTextStyle.mediumWhiteBold,
                    )),
                    drawerWidget("aboutUs", onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    }),

                    dataStore.user == null
                        ? drawerWidget("login", onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignIn()));
//                  setState(() {
//
//                  });
                          })
                        : Container(),

                    dataStore.user == null
                        ? drawerWidget("signUp", onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()));
//                  setState(() {
//
//                  });
                          })
                        : Container(),

                    dataStore.user != null && !dataStore.user.data.isProvider
                        ? drawerWidget("myAccount", onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDetails()));
                          })
                        : Container(),
                    dataStore.user != null
                        ? drawerWidget("history", onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    (!dataStore.user.data.isProvider)
                                        ? UserHistoryPage()
                                        : ServiceProviderHistory()));
                          })
                        : Container(),

                    dataStore.user != null && dataStore.user.data.isProvider
                        ? drawerWidget("showQR", onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ScanCode(providerID: dataStore.user.data.qrCode,)));
                          })
                        : Container(),

                    dataStore.user == null
                        ? drawerWidget("serviceProviderLogin", onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignIn(
                                      type: "ServiceProvider",
                                    )));
//                  setState(() {
//
//                  });
                          })
                        : Container(),

                    drawerWidget("language", onTap: () async{
                    await  showChangeLanguageDialog(context);
                    setState(() {
                      widget.bloc.getMyCard();
                    });
                    }),

                    drawerWidget("termsOfService", onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TermsOfServicePage()));
                    }),
                    drawerWidget("privacyPolicy", onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage()));
                    }),

                    drawerWidget("faq", onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => FAQ()));
                    }),
                    dataStore.user != null && !dataStore.user.data.isProvider
                        ?
                         drawerWidget("notification", onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                          }): Container(),

                    dataStore.user != null
                        ? drawerWidget("logout", onTap: () async {
                            dataStore.setUser(null).then((value) {
                              widget.bloc.refreshHome();
                              try{
                                genBloc.updateTokenProvider('.');
                              }catch(_){
                              }

                              setState(() {});
                            });
                          })
                        : Container(),
                    //Expanded(child: Container()),
                    SocialLinksWidget(),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          //width: 270,
          //color: AppColors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Column(
                children: <Widget>[
                  dataStore.user != null && dataStore.user.data.isProvider
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0)),
                                    padding: EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: CachedNetworkImage(
                                        imageUrl: AppConstant.IMAGE_URL +
                                            dataStore.user.data.photo,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataStore.user.data.isProvider
                                            ? dataStore.lang == "ar"
                                                ? dataStore
                                                    .user.data.businessName
                                                : (dataStore.user.data
                                                        .businessNameEn ??
                                                    "")
                                            : dataStore.user.data.name,
                                        style: AppTextStyle.largeWhiteBold,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        dataStore.user.data.phoneNumber,
                                        style: AppTextStyle.mediumWhiteBold,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        dataStore.user.data.email,
                                        style: AppTextStyle.mediumWhiteBold,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  StreamBuilder<ImageSliderModel>(
                      stream: widget.bloc.imageSliderStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0)),
                            child: Container(
                              height: height * 0.35,
                              decoration: BoxDecoration(),
                              child: Swiper(
                                itemCount: snapshot.data.data.length,
                                // snapshot.data.slider.length,
                                autoplay: true,
                                pagination: SwiperPagination(
                                  alignment: Alignment.bottomCenter,
                                  builder: DotSwiperPaginationBuilder(
                                    activeColor: AppColors.cyan,
                                    color: Colors.black12,
                                  ),
                                ),
                                itemBuilder: (context, index) {
                                  //print(AppConstant.IMAGE_URL + snapshot.data.data[index].photo);
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${AppConstant.IMAGE_URL + snapshot.data.data[index].photo}',
                                          //"https://img.freepik.com/free-vector/breaking-news-live-world-map-connection_41981-1139.jpg?size=626&ext=jpg",
                                          //"assets/images/home_page_image.png",
                                          fit: BoxFit.fill,
                                          height: height * 0.3,
                                          width: width,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                outer: true,
                              ),
                            ),
                          );
                        else
                          return Container(
                            height: height * 0.35,
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                      }),
                  dataStore.user == null || !dataStore.user.data.isProvider
                      ? StreamBuilder<UserActiveCardModel>(
                          stream: widget.bloc.userCardStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container(
                                height: 400,
                                width: double.infinity,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .trans("wrong"),
                                        style: AppTextStyle.mediumRed,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            widget.bloc.getMyCard();
                                          },
                                          child: Icon(
                                            Icons.refresh,
                                            color: AppColors.white,
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData || dataStore.user == null) {
                              return Column(
                                children: [
                                  Container(
                                    height: cardHeight,
                                    child: Row(
                                      children: [
                                        snapshot.hasData &&
                                                snapshot.data.code == 200
                                            ? homeCard(
                                                name: 'myCard',
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) => UseCard(
                                                              snapshot
                                                                  .data.data.id
                                                                  .toString(),
                                                              snapshot.data.data
                                                                  .card,
                                                              snapshot.data.data
                                                                  .createAt,
                                                              snapshot.data.data
                                                                  .expireAt)));
                                                })
                                            : homeCard(
                                                name: 'orderCard',
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CardsPage()));
                                                }),
                                        homeCard(
                                            name: 'placesNearYou',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NearestServiceProvider()));
                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: singleCardHeight,
                                    child: Row(
                                      children: [
                                        homeCard(
                                            name: 'markets',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NetworksPage()));
                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: singleCardHeight,
                                    child: Row(
                                      children: [
                                        homeCard(
                                            name: 'couponsGifts',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NetworksPage(
                                                            type: "coupons",
                                                          )));
                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: cardHeight,
                                    child: Row(
                                      children: [
                                        homeCard(
                                            name: 'joinUs',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddServiceProvider()));
                                            }), //AddServiceProvider
                                        homeCard(
                                            name: 'latestNews',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewsPage()));
                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: cardHeight,
                                    child: Row(
                                      children: [
                                        homeCard(
                                            name: 'sellCenters',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SalesCentersPage()));
                                            }),
                                        homeCard(
                                            name: 'contactUs',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ContactUs();
                                              }));
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container(
                              height: 400,
                              width: double.infinity,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          })
                      : Container(
                          height: cardHeight,
                          child: Row(
                            children: [
                              homeCard(
                                  name: 'showQR',
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ScanCode(providerID: dataStore.user.data.qrCode,)));
                                  }),
                              homeCard(
                                  name: 'history',
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServiceProviderHistory()));
                                  }),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void init() {
    widget.bloc.getImageSlider();
    widget.bloc.getMyCard();
    Future.delayed(Duration(seconds: 10), () {
      genBloc.getSocialLinks();
    });
  }

  Widget homeCard({String name, Function onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        highlightColor: AppColors.orange.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.black.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: Offset(0, 0))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                      // color: AppColors.pink.withOpacity(0.5)
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/${name == "myCard" ? "orderCard" : (name == "showQR" || name == "history") ? "markets" : name}.jpg'),
                          //NetworkImage("https://picsum.photos/500?salt=${math.Random().nextInt(10)}"),
                          alignment: Alignment.center,
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          //color: AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColors.cyan, width: 2)),
                      child: Text(
                        AppLocalizations.of(context).trans(name),
                        maxLines: 1,
                        style: AppTextStyle.mediumBlackBold.copyWith(
                            color: AppColors.cyan,
                            fontSize: MediaQuery.of(context).size.width <= 300
                                ? 10
                                : 14),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  drawerWidget(text, {Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          AppLocalizations.of(context).trans(text),
          style: AppTextStyle.mediumCyanBold,
        ),
      ),
    );
  }

  Future<bool> isFirstTime() async {
    packageInfo = await PackageInfo.fromPlatform();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }
}
