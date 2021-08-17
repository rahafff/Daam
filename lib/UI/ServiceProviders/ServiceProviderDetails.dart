import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/Home/ImageSlider.dart';
import 'package:first_card_project/Models/ServiceProviderDetailsModel.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/UI/Coupons/ServiceProviderCoupons.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
//import 'package:first_card_project/Widget/AppleMap.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/GoogleMap.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/SocialLinksWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../BaseUI.dart';

class ServiceProviderDetails extends BaseUI<ServiceProvidersBloc> {
  final String providerId;
  final ServiceProvidersBloc bloc;

  ServiceProviderDetails({this.providerId, this.bloc})
      : super(bloc: ServiceProvidersBloc());

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends BaseUIState<ServiceProviderDetails> {
  @override
  AppBar buildAppBar() {
    return null;
  }

  bool _isLoading = false;
  LatLng _center;
  Position currentLocation;
  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<ServiceProviderDetailsModel>(
        stream: widget.bloc.servicesDetailsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  snapshot.data.data.businessName,
                  style: AppTextStyle.normalWhiteBold.copyWith(
                      fontWeight: FontWeight.bold /*,color: AppColors.orange*/),
                ),
                backgroundColor: AppColors.lightBlack,
                centerTitle: true,
                elevation: 1,
                iconTheme: IconThemeData(color: AppColors.white),
                actions: [
                  dataStore.user == null || snapshot.data.data.canRate == 0
                      ? Container()
                      : InkWell(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.star_rate,
                                  size: 25,
                                ),
                                Text(
                                  AppLocalizations.of(context).trans("rate"),
                                  style: AppTextStyle.smallWhiteBold,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            //snapshot.data.data.ra
                            var res = await showDialog<double>(
                                context: context,
                                builder: (context) {
                                  double rate =
                                      snapshot.data.data.rate.toDouble();
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(AppLocalizations.of(context)
                                                .trans("rate") +
                                            " " +
                                            snapshot.data.data.businessName),
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
                                            Navigator.of(context).pop(rate);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                });

                            if (res != null) {
                              setState(() {
                                _isLoading = true;
                              });
                              widget.bloc.addRate(
                                  serviceProviderId:
                                      widget.providerId.toString(),
                                  rate: res.toString(),
                                  onData: () {
                                    showErrorDialog(
                                        context,
                                        AppLocalizations.of(context)
                                            .trans("ratedSuccessfully"),
                                        isError: false);
                                    snapshot.data.data.rate = res;
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  onError: (String e) {
                                    showErrorDialog(
                                        context,
                                        e.isEmpty
                                            ? AppLocalizations.of(context)
                                                .trans("wrong")
                                            : e,
                                        isError: true);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                            }
                          },
                        )
                ],
              ),
              body: ModalProgressHUD(
                inAsyncCall: _isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<ImageSliderModel>(
                          stream: widget.bloc.imageSliderStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0)),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
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
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: double.infinity,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                          }),
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.3,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: CachedNetworkImage(
                      //     imageUrl: AppConstant.IMAGE_URL + snapshot.data.data.photo,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          socialItem(
                              name: 'facebook',
                              links: snapshot.data.data.facebook),
                          socialItem(
                              name: 'instagram',
                              links: snapshot.data.data.instagram),
                          socialItem(
                              name: 'linkedin',
                              links: snapshot.data.data.linkedIn),
                          socialItem(
                              name: 'youtube',
                              links: snapshot.data.data.youtube),
                          socialItem(
                              name: 'mail', links: snapshot.data.data.email),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .trans("businessType"),
                                  style: AppTextStyle.mediumWhiteBold,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  snapshot.data.data.businessType.name,
                                  style: AppTextStyle.mediumWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              height: 17,
                              color: AppColors.white,
                              width: 1,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context).trans("network"),
                                  style: AppTextStyle.mediumWhiteBold,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  snapshot.data.data.network.name,
                                  style: AppTextStyle.mediumWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              height: 17,
                              color: AppColors.white,
                              width: 1,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context).trans("city"),
                                  style: AppTextStyle.mediumWhiteBold,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  snapshot.data.data.city.name,
                                  style: AppTextStyle.mediumWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: AppColors.white,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(5)),
                              child: SvgPicture.asset(
                                "assets/images/apple.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data.data.phoneNumber,
                            style: AppTextStyle.mediumWhiteBold,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             color: AppColors.orange,
                      //             borderRadius: BorderRadius.circular(5)),
                      //         child: SvgPicture.asset(
                      //           "assets/images/mail.svg",
                      //           height: 20,
                      //           width: 20,
                      //         ),
                      //       ),
                      //     ),
                      //     Text(
                      //       snapshot.data.data.email,
                      //       style: AppTextStyle.mediumWhiteBold,
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.orange,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.location_city,
                                  size: 20,
                                )),
                          ),
                          Flexible(
                            child: Text(
                              snapshot.data.data.location,
                              style: AppTextStyle.mediumWhiteBold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ServiceProviderCouponsPage(
                                    serviceProviderName:
                                    snapshot.data.data.businessName,
                                    serviceProviderId:
                                    snapshot.data.data.id.toString(),
                                    networkId:
                                    snapshot.data.data.networkId.toString(),
                                  );
                                }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.orange,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .trans("showCoupons"),
                                        style: AppTextStyle.mediumWhiteBold,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 24,
                                        color: AppColors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              String origin =
                                  "${_center.latitude},${_center.longitude}"; // lat,long like 123.34,68.56
                              String destination =
                                  "${double.parse(snapshot.data.data.latitude ?? "0.0")},${double.parse(snapshot.data.data.longitude ?? "0.0")}";
                              print("now lanuch");
                              Utils.lunchURL(
                                  "https://www.google.com/maps/dir/?api=1&origin=" +
                                      origin +
                                      "&destination=" +
                                      destination);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .trans("direction"),
                                      style: AppTextStyle.mediumWhiteBold,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Icon(
                                      Icons.location_on,
                                      size: 24,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],),


                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Html(
                                  data: snapshot.data.data.description,
                                  // customTextAlign: (element) {
                                  //   return TextAlign.start;
                                  // },
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            snapshot.data.data.longitude == null
                                ? Container()
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: double.infinity,
                                    child: //AppleMapWidget
                                        MapWidget(LatLng(
                                            double.parse(
                                                snapshot.data.data.latitude ??
                                                    "0.0"),
                                            double.parse(
                                                snapshot.data.data.longitude ??
                                                    "0.0")),center: _center,),

//                    child: Image.asset(
//                      "assets/images/map.jpg",
//                      fit: BoxFit.cover,
//                    ),
                                  ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  void init() {
    widget.bloc.getServiceProvider(providerId: widget.providerId);
    widget.bloc.getImageSlider(widget.providerId);
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $_center');
  }
}
