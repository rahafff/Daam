import 'package:first_card_project/Bloc/CouponsBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/UI/Coupons/CouponCard.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

import '../BaseUI.dart';


class ServiceProviderCouponsPage extends BaseUI<CouponsBloc> {

  final String serviceProviderId;
  final String serviceProviderName;
  final String networkId;

  @override
  _ServiceProviderCouponsPageState createState() => _ServiceProviderCouponsPageState();

  ServiceProviderCouponsPage({this.serviceProviderId,this.serviceProviderName,this.networkId}):super(bloc:CouponsBloc());
}

class _ServiceProviderCouponsPageState extends BaseUIState<ServiceProviderCouponsPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("couponsGifts")+" "+widget.serviceProviderName??"");
  }

  @override
  Widget buildUI(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<CouponsModel>(
              stream: widget.bloc.couponsStream,
              builder: (context, snapshot) {
                if(snapshot.hasData && (snapshot.data.data == null || snapshot.data.data.isEmpty))
                {
                  return Center(
                    child: Text(AppLocalizations.of(context).trans("noCoupons"),style: AppTextStyle.normalWhiteBold,),
                  );
                }
                if(snapshot.hasData)
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if(snapshot.data.data.length == index)
                      {
                        if(widget.bloc.canLoad)
                        {
                          widget.bloc.loadMore(cityId: "", businessTypeId: "",reserved: "" ,networkId: widget.networkId,serviceProviderId: widget.serviceProviderId);
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else return Container();
                      }
                      return CouponCard(
                        data: snapshot.data.data[index],
                      );
                      return Container();
                    },
                    itemCount: snapshot.data.data.length+1,padding: const EdgeInsets.only(top: 16 , bottom: 16),
                  );
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
        ),
      ],
    );

  }

  @override
  void init() {
    getData();
  }

  getData(){
    widget.bloc.getCoupons(cityId: "", businessTypeId: "",reserved: "" ,networkId: widget.networkId,serviceProviderId: widget.serviceProviderId);
  }
}
