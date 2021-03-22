import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/ServiceProviderCard.dart';
import 'package:flutter/material.dart';

class SearchPage extends BaseUI<ServiceProvidersBloc> {
  @override
  _SearchPageState createState() => _SearchPageState();

  SearchPage() : super(bloc: ServiceProvidersBloc());
}

class _SearchPageState extends BaseUIState<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.lightBlack,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              cursorColor: AppColors.white,
              style: AppTextStyle.mediumWhiteBold,
              autofocus: true,
              onSubmitted: (val) {
                if (val.isNotEmpty) widget.bloc.searchServiceProviders(val);
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white),
                  )),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
              onTap: () {
                if (_searchController.text.isEmpty) return;
                widget.bloc.searchServiceProviders(_searchController.text);
              },
              child: Icon(
                Icons.search_sharp,
                size: 24,
                color: AppColors.white,
              ))
        ],
      ),
    );
  }

  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<ServiceProvidersModel>(
      stream: widget.bloc.searchServicesStream,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.data.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/noResults.png",
                  color: AppColors.white,
                  width: 100,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(AppLocalizations.of(context).trans("noResults"),style: AppTextStyle.mediumWhiteBold,)
              ],
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return ServiceProviderCard(
              bloc: widget.bloc,
              data: snapshot.data.data[index],
            );
          },
          itemCount: snapshot.data.data.length,
        );
      } else {
        if (widget.bloc.isSearching)
          return Center(
            child: CircularProgressIndicator(),
          );

        return Center(
          child: Text(
            AppLocalizations.of(context).trans("searchFor"),
            style: AppTextStyle.normalWhiteBold,
          ),
        );
      }
    });
  }

  @override
  void init() {
    // TODO: implement init
  }
}
