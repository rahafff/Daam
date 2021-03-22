import 'package:first_card_project/Bloc/CardsBloc.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CardsModel.dart';
import 'package:first_card_project/Widget/CardCard.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:first_card_project/UI/BaseUI.dart';

class CardsPage extends BaseUI<CardsBloc> {
  @override
  _CardsPageState createState() => _CardsPageState();

  CardsPage():super(bloc:CardsBloc());

}

class _CardsPageState extends BaseUIState<CardsPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("cards"));
  }

  @override
  Widget buildUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constrains) {
        return StreamBuilder<CardsModel>(
            stream: widget.bloc.cardsStream,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data.data == null)
              {
                return helper.empty(context);
              }
              if(snapshot.hasData)
                return Container(
                  width: constrains.maxWidth,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      /*  if(snapshot.data.data.length == index)
                      {
                        if(_bloc.canLoad)
                        {
                          _bloc.f_loadMore();
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else return Container();
                      }*/
                      return CardCard(
                        data: snapshot.data.data[index],
                        bloc: widget.bloc,
                      );
                    },
                    itemCount: snapshot.data.data.length+0,padding: const EdgeInsets.only(top: 16 , bottom: 16),
                  ),
                );
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        );
      },
    );
  }

  @override
  void init() {
    widget.bloc.getCards();
  }

}
