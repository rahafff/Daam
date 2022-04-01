import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/CouponsBloc.dart';
import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CardsModel.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/UI/Coupons/UseCoupon.dart';
import 'package:first_card_project/UI/ServiceProviders/ServiceProviderDetails.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../DataStore.dart';
import '../SignIn.dart';
class CouponDetails extends BaseUI<CouponsBloc> {
  final String couponId;

  CouponDetails({this.couponId}) : super(bloc: CouponsBloc());

  @override
  _CouponDetailsState createState() => _CouponDetailsState();
}

class _CouponDetailsState extends BaseUIState<CouponDetails> {

  Widget dataRow({name, value,onTap}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  name,
                  style: AppTextStyle.mediumWhite,
                ),
              ),
              Expanded(
                  //flex: 3,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        value,
                        style: AppTextStyle.mediumWhiteBold,
                        textAlign: TextAlign.center,
                      ),
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
    return null;
  }

  bool isLoading = false;
  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<CouponDetailsModel>(
      stream: widget.bloc.couponDetailsStream,
      builder: (context, snapshot) {
        if(snapshot.hasData)
          return Scaffold(
              appBar: helper.mainAppBar(context, snapshot.data.data.name),
              body: ModalProgressHUD(
                inAsyncCall: isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                        tag: snapshot.data.data.id.toString() + "img",
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: AppConstant.IMAGE_URL + snapshot.data.data.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      dataRow(
                          name: AppLocalizations.of(context).trans("name"),
                          value: snapshot.data.data.name ,
                      //     onTap: (){
                      //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      //     return ServiceProviderDetails(providerId: snapshot.data.data.serviceProvider.id.toString(),bloc:ServiceProvidersBloc());
                      //   }));
                      // }
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.all(8),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(AppLocalizations.of(context).trans("serviceProviderName"),  style: AppTextStyle.mediumWhite,),
                            ),
//                            SizedBox(width: 10,),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(snapshot.data.data.serviceProvider.businessName, style: AppTextStyle.mediumWhiteBold,),
                              ),
                            ),

                          ],
                        ),
                      ),
                      CustomAppButton(
                        child: Text(
                          AppLocalizations.of(context).trans("showDetails"),
                          style: AppTextStyle.mediumWhiteBold,
                        ),
                        color: AppColors.cyan,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return ServiceProviderDetails(providerId: snapshot.data.data.serviceProvider.id.toString(),bloc:ServiceProvidersBloc());
                          }));
                        },
                        padding:
                        EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                        borderRadius: 20,
                        elevation: 2,
                      ),
                      Divider(
                        color: AppColors.orange,
                        thickness: 1.5,
                      ),
                      // dataRow(
                      //     name: AppLocalizations.of(context).trans("card"),
                      //     value: widget.data.card.name),
                      // dataRow(
                      //     name: AppLocalizations.of(context).trans("expiry"),
                      //     value: widget.data.expireAt +
                      //         "  " +
                      //         AppLocalizations.of(context).trans("day")),

                      dataRow(
                          name: AppLocalizations.of(context).trans("number_of_usage"),
                          value: snapshot.data.data.numberOfUsage.toString()),
                      dataRow(
                          name: AppLocalizations.of(context).trans("expiryDate"),
                          value: snapshot.data.data.expireAt ),
                      dataRow(
                          name: AppLocalizations.of(context).trans("reservation_period"),
                          value: snapshot.data.data.reservationPeriod+"  " +
                          AppLocalizations.of(context).trans("day")),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data.data.description,
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
                            child: Text(AppLocalizations.of(context).trans("loginToUseCoupon"),style: AppTextStyle.mediumWhiteBold.copyWith(
                                decoration: TextDecoration.underline
                            ),),
                          ),
                        ),
                      ) :
                          snapshot.data.data.reserved != null && snapshot.data.data.reserved == 1?
                      Container(
                        child: Center(
                          child: CustomAppButton(
                            child: Text(
                              AppLocalizations.of(context).trans("userCoupon"),
                              style: AppTextStyle.mediumWhiteBold,
                            ),
                            color: AppColors.cyan,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UseCoupon(couponId: snapshot.data.data.id.toString(),coupon: snapshot.data.data,)
                              ));
                            },
                            padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                            borderRadius: 20,
                            elevation: 2,
                          ),
                        ),
                      ):Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomAppButton(
                                    child: Text(
                                      AppLocalizations.of(context).trans("reserveCoupon"),
                                      style: AppTextStyle.mediumWhiteBold,
                                    ),
                                    color: AppColors.cyan,
                                    onTap: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      widget.bloc.reserveCoupon(
                                        couponId: widget.couponId,
                                        onData: (val){
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if(val.code > 0){
                                            snapshot.data.data.reserved = 1;
                                          }
                                          else{
                                            showErrorDialog(context, val?.message);
                                          }
                                          widget.bloc.update(snapshot.data);

                                        }
                                      );
                                    },
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                                    borderRadius: 20,
                                    elevation: 2,
                                  ),

                                ],
                              ),
                            ),
                          )
                      ,
                      SizedBox(height: 16,)
                    ],
                  ),
                ),
              )
          );
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  @override
  void init() {
    widget.bloc.getCouponDetails(widget.couponId);
  }

}
