import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/CardsBloc.dart';
import 'package:first_card_project/Bloc/CouponsBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/Models/SerialNumbersModel.dart';
import 'package:first_card_project/Models/UserActiveCard.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseCoupon extends BaseUI<CouponsBloc> {
  final String couponId;
  final Coupon coupon;

  UseCoupon({Key key, this.couponId, this.coupon}) : super(bloc:CouponsBloc());
  @override
  _UseCouponState createState() => _UseCouponState();
}

class _UseCouponState extends BaseUIState<UseCoupon> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("userCoupon"));
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
                                  AppConstant.IMAGE_URL + widget.coupon.image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),SizedBox(width: 8,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.coupon.name,
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
                    duration: Duration(seconds: 1),
                    pause: Duration(seconds: 0),
                    textStyle: AppTextStyle.largeWhiteBold,
                    repeatForever: true,
                    onFinished: (){
                      widget.bloc.getNext(couponId: widget.couponId);
                    },
                    onNext: (index,val){
//                      print(index);
//                      print(val);
                      if(val) widget.bloc.getNext(couponId: widget.couponId);
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

          if(snapshot.hasError){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error , size: 40,color: AppColors.white,),
                  SizedBox(height: 8,),
                  Text(AppLocalizations.of(context).trans("cantUseCoupon"),style: AppTextStyle.mediumWhiteBold,),

                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });

  }

  @override
  void init() {
    widget.bloc.getSerialNumbers(couponId: widget.couponId);
  }
}
