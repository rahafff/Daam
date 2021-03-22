import 'package:first_card_project/Bloc/SalesCenterBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/SalesCenters.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/UI/SalesCenters/SalesCenterCard.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

class SalesCentersPage extends BaseUI<SalesCenterBloc> {
  @override
  _SalesCentersPageState createState() => _SalesCentersPageState();

  SalesCentersPage() : super(bloc: SalesCenterBloc());
}

class _SalesCentersPageState extends BaseUIState<SalesCentersPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context, AppLocalizations.of(context).trans("sellCenters"));
  }

  String cityId, cityName;

  @override
  Widget buildUI(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          filterWidget(
            label: AppLocalizations.of(context).trans("city"),
            selectedId: cityId,
            selectedName: cityName,
            onTap: () {
              helper.showCitySheet(context, onSelected: (name, id) {
                setState(() {
                  cityId = id?.toString() ?? null;
                  cityName = name;
                  getData();
                });
              }, optional: true);
            },
          ),
          Expanded(
              child: StreamBuilder<SalesCentersModel>(
                  stream: widget.bloc.salesCentersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.data == null) {
                      return helper.empty(context);
                    }
                    if (snapshot.hasData)
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (snapshot.data.data.length == index) {
                            if (widget.bloc.canLoad) {
                              widget.bloc.loadMore(cityId: cityId??"");
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else
                              return Container();
                          }
                          return SalesCenterCard(
                            data: snapshot.data.data[index],
                          );
                        },
                        itemCount: snapshot.data.data.length + 1,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                      );
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }))
        ],
      ),
    );
  }

  @override
  void init() {
    getData();
  }

  getData() {
    widget.bloc.getSalesCenters(cityId: cityId ?? "");
  }

  filterWidget({label, selectedId, selectedName, onChanged, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Text(
                label + ': ',
                style: AppTextStyle.mediumWhite,
              ),
              Expanded(
                  child: Text(
                selectedName ??
                    AppLocalizations.of(context).trans("notSelected"),
                style: AppTextStyle.mediumWhiteBold,
                textAlign: TextAlign.center,
              )),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.white,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
