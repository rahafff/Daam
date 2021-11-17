import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CouponHistoryModel.dart';
import 'package:first_card_project/Models/History.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

import '../../DataStore.dart';
class ServiceProviderHistory extends BaseUI<ServiceProvidersBloc> {
  @override
  _ServiceProviderHistoryState createState() => _ServiceProviderHistoryState();

  ServiceProviderHistory():super(bloc: ServiceProvidersBloc());
}

class _ServiceProviderHistoryState extends BaseUIState<ServiceProviderHistory> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("history"));
  }

  bool isCard = true;
  @override
  Widget buildUI(BuildContext context) {
    print(isCard);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    if(isCard) return;
                    widget.bloc.getHistory();
                    setState(() {
                      isCard = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      AppLocalizations.of(context).trans("cards"),
                      textAlign: TextAlign.center,
                      style: isCard
                          ? AppTextStyle.mediumWhiteBold
                          : AppTextStyle.mediumWhiteBold
                          .copyWith(color: AppColors.white.withOpacity(0.3)),
                    ),
                  )),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: GestureDetector(
                  onTap: (){
                    if(!isCard) return;
                    widget.bloc.getCouponHistory();
                    setState(() {
                      isCard = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      AppLocalizations.of(context).trans("coupons"),
                      textAlign: TextAlign.center,
                      style: !isCard
                          ? AppTextStyle.mediumWhiteBold
                          : AppTextStyle.mediumWhiteBold
                          .copyWith(color: AppColors.white.withOpacity(0.3),
                      ),
                    ),
                  )),
            ),
          ],
        ),
        SizedBox(height: 8,),
        getBody()
      ],
    );
  }

  @override
  void init() {
    widget.bloc.getHistory();
  }

  historyCard(HistoryElement item){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),

        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("clientName")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Text(item.card.user.name , style: AppTextStyle.mediumBlack,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("value")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Text(item.value , style: AppTextStyle.mediumBlack,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("card")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Text(dataStore.lang =='en'? item.card.card.name_en : item.card.card.name, style: AppTextStyle.mediumBlack,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("date")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Column(
                  children: [
                    Text(Utils.getDate(item.createdAt) , style: AppTextStyle.mediumBlack,),
                    Text(Utils.getTime(item.createdAt) , style: AppTextStyle.mediumBlack,),

                  ],
                )
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }

  couponHistoryCard(ServiceCouponHistory item){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),

        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("value")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Text(item.value , style: AppTextStyle.mediumBlack,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("coupon")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Text(dataStore.lang =='en'? item.coupon.name_en??'': item.coupon.name??'', style: AppTextStyle.mediumBlack,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text(AppLocalizations.of(context).trans("date")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Column(
                  children: [
                    Text(Utils.getDate(item.createdAt) , style: AppTextStyle.mediumBlack,),
                    Text(Utils.getTime(item.createdAt) , style: AppTextStyle.mediumBlack,),

                  ],
                )
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }


  getBody(){
    if(isCard)
    return Expanded(
      child: StreamBuilder<History>(
          stream: widget.bloc.historyStream,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).trans("totalValue")+ " : ",style: AppTextStyle.largeBlack.copyWith(color: AppColors.white),),
                        SizedBox(width: 8,),
                        Text(snapshot.data.data.totalValue.toString(), style: AppTextStyle.largeWhiteBold,)
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).trans("totalCount")+ " : ",style: AppTextStyle.largeBlack.copyWith(color: AppColors.white),),
                        SizedBox(width: 8,),
                        Text(snapshot?.data?.data?.totalCount?.toString()??"", style: AppTextStyle.largeWhiteBold,)
                      ],
                    ),
                    ListView.builder(itemBuilder: (context,index){
                      return historyCard(snapshot.data.data.history[index]);
                    },
                      itemCount: snapshot.data.data.history.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );


    else return Expanded(
      child: StreamBuilder<CouponHistoryModel>(
          stream: widget.bloc.couponHistoryStream,
          builder: (context,snapshot){
            print(snapshot.hasData);
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).trans("totalValue")+ " : ",style: AppTextStyle.largeBlack.copyWith(color: AppColors.white),),
                        SizedBox(width: 8,),
                        Text(snapshot.data.data.totalValue.toString(), style: AppTextStyle.largeWhiteBold,)
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).trans("totalCount")+ " : ",style: AppTextStyle.largeBlack.copyWith(color: AppColors.white),),
                        SizedBox(width: 8,),
                        Text(snapshot?.data?.data?.totalCount?.toString()??"", style: AppTextStyle.largeWhiteBold,)
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).trans("remainingCoupons")+ " : ",style: AppTextStyle.largeBlack.copyWith(color: AppColors.white),),
                        SizedBox(width: 8,),
                        Text(snapshot?.data?.data?.remainingCoupons?.toString()??"", style: AppTextStyle.largeWhiteBold,)
                      ],
                    ),
                    ListView.builder(itemBuilder: (context,index){
                      return couponHistoryCard(snapshot.data.data.history[index]);
                    },
                      itemCount: snapshot.data.data.history.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),);
  }
}
