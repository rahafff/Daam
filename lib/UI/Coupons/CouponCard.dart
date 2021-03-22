import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/UI/Coupons/CouponDetails.dart';
import 'package:flutter/material.dart';

import 'UseCoupon.dart';

class CouponCard extends StatelessWidget {
  final Coupon data;

  const CouponCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       // if(dataStore.user!=null)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CouponDetails(couponId: data.id.toString(),)
          ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: AppColors.green , ),
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white /*.withOpacity(0.01)*/
              ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(200)),
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CachedNetworkImage(
                        imageUrl: AppConstant.IMAGE_URL + data.image,
                        width: 75,
                        height: 75,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: AppTextStyle.mediumBlack,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.serviceProvider.businessName,
                        style: AppTextStyle.smallBlackThin,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(dataStore.lang == 'en'? 50:0),
                              topRight: Radius.circular(dataStore.lang == 'ar'? 50:0),
                              bottomLeft: Radius.circular(dataStore.lang == 'ar'? 20:0),
                              bottomRight: Radius.circular(dataStore.lang == 'en'? 20:0),
                            ),
                            child: Container(
                              color: AppColors.orange,
                                width: 70,
                                padding: EdgeInsets.all(12),
                                alignment: Alignment.center,//dataStore.lang == "ar"? Alignment.centerLeft : Alignment.centerRight,
                                child: Text(
                              /*AppLocalizations.of(context).trans("number_of_usage") + ' '+*/
                              data.number?.toString()??"",
                              style: AppTextStyle.smallWhiteBold,
                            )),
                          ),

                          // Text(AppLocalizations.of(context).trans("reservation_period") + ' '+data.reservationPeriod , style: AppTextStyle.smallBlackBold,),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
