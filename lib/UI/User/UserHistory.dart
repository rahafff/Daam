import 'package:first_card_project/Bloc/AuthBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/History.dart';
import 'package:first_card_project/Models/UserCouponHistoryModel.dart';
import 'package:first_card_project/Models/UserHistory.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
class UserHistoryPage extends BaseUI<AuthBloc> {
  @override
  _UserHistoryState createState() => _UserHistoryState();

  UserHistoryPage():super(bloc: AuthBloc());
}

class _UserHistoryState extends BaseUIState<UserHistoryPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("history"));
  }

  bool isCard = true;
  bool isEn = false;

  @override
  Widget buildUI(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    if(isCard) return;
                    widget.bloc.getUserHistory();
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
                    widget.bloc.getUserCouponHistory();
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
                          : AppTextStyle.mediumWhiteBold.copyWith(color: AppColors.white.withOpacity(0.3),
                      ),
                    ),
                  )),
            ),
          ],
        ),
        SizedBox(height: 8,),

        isCard?Expanded(
          child: StreamBuilder<UserHistoryModel>(
              stream: widget.bloc.userHistoryStream,
              key: UniqueKey(),
              builder: (context,snapshot){
                if(snapshot.hasData){

                  if(snapshot.data.data == null) return Container();
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
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).trans("totalUsage")+ " : ",style: AppTextStyle.largeBlack.copyWith(color: AppColors.white),),
                            SizedBox(width: 8,),
                            Text(snapshot.data.data.totalUsage.toString(), style: AppTextStyle.largeWhiteBold,)
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
        ):
        Expanded(
          child: StreamBuilder<UserCouponHistoryModel>(
              stream: widget.bloc.userCouponHistoryStream,
              key: UniqueKey(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.data == null) return Container();
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
              }),
        ),
      ],
    );
  }

  @override
  void init() {
   isEn =  dataStore.lang =='en';
    widget.bloc.getUserHistory();
  }

  historyCard(HistoryUser item){
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
                Text(AppLocalizations.of(context).trans("serviceProviderName")+" : " , style: AppTextStyle.mediumBlackBold,),
                SizedBox(width: 8,),
                Text( isEn ? item.serviceProvider.businessName_en : item.serviceProvider.businessName  , style: AppTextStyle.mediumBlack,)
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
                Text( isEn? item.card.card.name_en  : item.card.card.name , style: AppTextStyle.mediumBlack,)
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

  couponHistoryCard(CouponHistory item){
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
                Text(isEn? item?.coupon?.name_en??"" : item?.coupon?.name??"" , style: AppTextStyle.mediumBlack,)
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

}
