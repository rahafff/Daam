import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/pageModel.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/ServiceProviderCard.dart';
import 'package:first_card_project/Widget/page_number.dart';
import 'package:flutter/material.dart';

class ServiceProvidersPage extends BaseUI<ServiceProvidersBloc> {
  final String networkId;
  final String networkName;

  @override
  _ServiceProvidersPageState createState() => _ServiceProvidersPageState();

  ServiceProvidersPage({this.networkId,this.networkName}) : super(bloc: ServiceProvidersBloc());
}

class _ServiceProvidersPageState extends BaseUIState<ServiceProvidersPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context, /*AppLocalizations.of(context).trans("markets")+" "+*/widget.networkName??"");
  }

  String cityId , cityName;

  String businessId , businessName;
  int counter;
  List<PageModel> pages;
  @override
  Widget buildUI(BuildContext context) {
    return Column(
      children: [
        Container(
//          height: MediaQuery.of(context).size.height*0.05,
          child: Column(
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

            ],
          ),
        ),
        Expanded(
            child: StreamBuilder<ServiceProvidersModel>(
                stream: widget.bloc.servicesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.data == null) {
                    return helper.empty(context);
                  }
                  if (snapshot.hasData) {
                   if(pages.isEmpty){
                     for (int i = 0; i <= snapshot.data.dataCount; i++) {
                       if(i == 0 ){
                         pages.add(PageModel(isSelected: true,number: (i+1).toString()));
                       }
                       else  pages.add(PageModel(isSelected: false,number: (i+1).toString()));
                     }
                   }
                   else if (pages.length != snapshot.data.dataCount+1){
                     pages = [];
                     for (int i = 0; i <= snapshot.data.dataCount; i++) {
                       if(i == 0 ){
                         pages.add(PageModel(isSelected: true,number: (i+1).toString()));
                       }
                       else  pages.add(PageModel(isSelected: false,number: (i+1).toString()));
                     }
                   }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              //       if(snapshot.data.data.length == index)
                              // {
                              //   if(widget.bloc.canLoad)
                              //   {
                              //     counter = counter+1;
                              //     widget.bloc.loadMore( cityId: cityId??"", businessTypeId: businessId??"", networkId: widget.networkId);
                              //     return Center(
                              //       child: CircularProgressIndicator(),
                              //     );
                              //   }
                              //   else return Container();
                              // }
                              return ServiceProviderCard(
                                data: snapshot.data.data[index],
                                bloc: widget.bloc,
                              );
                            },
                            itemCount: snapshot.data.data.length,
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            shrinkWrap: true,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('رقم الصفحة: ', style: AppTextStyle
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
                                          widget.bloc.getServices(
                                              offset: index * 10,
                                              cityId: cityId ?? "",
                                              businessTypeId: businessId ?? "",
                                              networkId: widget.networkId);
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
                }))
      ],
    );
  }

  getData(){
    widget.bloc.getServices(offset: 0,
        cityId: cityId??"", businessTypeId: businessId??"", networkId: widget.networkId);
  }
  @override
  void init() {
    counter = 1;
    pages = [];
    getData();

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
