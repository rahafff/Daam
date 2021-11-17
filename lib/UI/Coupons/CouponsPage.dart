import 'package:first_card_project/Bloc/CouponsBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CouponsModel.dart';
import 'package:first_card_project/Models/pageModel.dart';
import 'package:first_card_project/UI/Coupons/CouponCard.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/page_number.dart';
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
  int counter;
  List<PageModel> pages;
  @override
  Widget buildUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          child: Column(children: [
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
          ],),
        ),
        Expanded(
          child: StreamBuilder<CouponsModel>(
                  stream: widget.bloc.couponsStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData && snapshot.data.data == null)
                    {
                      return helper.empty(context);
                    }
                    if(snapshot.hasData){
                      if(pages.isEmpty){
                        if(snapshot.data.dataCount ==0){
                          pages.add(PageModel(isSelected: true,number: '1'));
                        }else {
                          for (int i = 1; i <= snapshot.data.dataCount; i++) {
                            if(i == 1 ){
                              pages.add(PageModel(isSelected: true,number: (i).toString()));
                            }
                            else  pages.add(PageModel(isSelected: false,number: (i).toString()));
                          }
                        }}
                      else if (pages.length != snapshot.data.dataCount && snapshot.data.dataCount != 0){
                        pages = [];
                        for (int i = 1; i <= snapshot.data.dataCount; i++) {
                          if(i == 1 ){
                            pages.add(PageModel(isSelected: true,number: (i).toString()));
                          }
                          else  pages.add(PageModel(isSelected: false,number: (i).toString()));
                        }
                      }else if (pages.length != snapshot.data.dataCount && snapshot.data.dataCount == 0){
                        pages = [];
                        pages.add(PageModel(isSelected: true,number: '1'));
                      }
                      return Column(
                        children: [

                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                // if(snapshot.data.data.length == index)
                                // {
                                //   if(widget.bloc.canLoad)
                                //   {
                                //     widget.bloc.loadMore(cityId: cityId??"", businessTypeId: businessId??"",reserved: reservedId??"" ,networkId: widget.networkId,serviceProviderId: "");
                                //     return Center(
                                //       child: CircularProgressIndicator(),
                                //     );
                                //   }
                                //   else return Container();
                                // }
                                return CouponCard(
                                  data: snapshot.data.data[index],
                                );
                                return Container();
                              },
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,padding: const EdgeInsets.only(top: 16 , bottom: 16),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(AppLocalizations.of(context).trans("pageNumber"), style: AppTextStyle
                                    .normalWhite,),),
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return PageNumber(
                                          model: pages[index],
                                          changePage: () {
                                            setState(() {
                                              pages.forEach((element) {
                                                element.isSelected = false;
                                              });
                                            });
                                            pages[index].isSelected = true;
                                            widget.bloc.getCoupons(cityId: cityId??"", businessTypeId: businessId??"",reserved: reservedId??"" ,networkId: widget.networkId,serviceProviderId: "",offset: index *10);

                                          });}
                                    , itemCount: pages.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  height: 48,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
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
    pages = [];
    counter = 1;
    getData();
  }

  getData(){
    widget.bloc.getCoupons(cityId: cityId??"", businessTypeId: businessId??"",reserved: reservedId??"" ,networkId: widget.networkId,serviceProviderId: "",offset: 0);
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
