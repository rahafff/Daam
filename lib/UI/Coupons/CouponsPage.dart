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


class CouponsPage extends BaseUI<CouponsBloc> {

  final String networkId;
  final String networkName;
  @override
  _CouponsPageState createState() => _CouponsPageState();

  CouponsPage({this.networkId,this.networkName}):super(bloc:CouponsBloc());
}

class _CouponsPageState extends BaseUIState<CouponsPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("couponsGifts")+" "+widget.networkName??"");
  }
  String cityId , cityName;

  String businessId , businessName;

  String reservedId , reservedName;
  @override
  Widget buildUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        filterWidget(
          label: AppLocalizations.of(context).trans("city"),
          selectedId: cityId,
          selectedName: cityName,
          onTap: (){
            helper.showCitySheet(context, onSelected: (name,id){
              setState(() {
                cityId = id?.toString()??null;
                cityName = name;
                getData();
              });
            },optional: true);
          },
        ),
        filterWidget(
            label: AppLocalizations.of(context).trans("businessType"),
            selectedId: businessId,
            selectedName: businessName,
            onTap: (){
              helper.showBusinessTypesSheet(context, widget.networkId,onSelected: (name,id){
                setState(() {
                  businessId = id?.toString()??null;
                  businessName = name;
                  getData();
                });
              },optional: true,refresh: true);
            }
        ),
        dataStore.user != null?filterWidget(
            label: AppLocalizations.of(context).trans("isReserved"),
            selectedId: reservedId,
            selectedName: reservedName,
            onTap: (){
              helper.showReservedSheet(context,onSelected: (name,id){
                setState(() {
                  reservedId = id?.toString()??null;
                  reservedName = name;
                  getData();
                });
              },optional: true);
            }
        ):Container(),
        Expanded(
          child: StreamBuilder<CouponsModel>(
                  stream: widget.bloc.couponsStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData && snapshot.data.data == null)
                    {
                      return helper.empty(context);
                    }
                    if(snapshot.hasData)
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if(snapshot.data.data.length == index)
                          {
                            if(widget.bloc.canLoad)
                            {
                              widget.bloc.loadMore(cityId: cityId??"", businessTypeId: businessId??"",reserved: reservedId??"" ,networkId: widget.networkId,serviceProviderId: "");
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
    widget.bloc.getCoupons(cityId: cityId??"", businessTypeId: businessId??"",reserved: reservedId??"" ,networkId: widget.networkId,serviceProviderId: "");
  }
  filterWidget({label,selectedId , selectedName , onChanged,onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Text(label+': ' , style: AppTextStyle.mediumWhite,),
              Expanded(child: Text(selectedName??AppLocalizations.of(context).trans("notSelected") , style: AppTextStyle.mediumWhiteBold,textAlign: TextAlign.center,)),
              Icon(Icons.arrow_drop_down , color: AppColors.white, size: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
