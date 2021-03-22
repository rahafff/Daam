import 'package:first_card_project/Bloc/NetworksBloc.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/NetworksModel.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/NetworkCard.dart';
import 'package:flutter/material.dart';

import 'BaseUI.dart';

class NetworksPage extends BaseUI<NetworkBloc> {

  final String type;
  @override
  _NetworksState createState() => _NetworksState();

  NetworksPage({this.type = "markets"}):super(bloc:NetworkBloc());
}

class _NetworksState extends BaseUIState<NetworksPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context,AppLocalizations.of(context).trans(widget.type));
  }

  @override
  Widget buildUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context , constrains){
        return StreamBuilder<NetworkModel>( //favorite api stream
            stream: widget.bloc.networkStream,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                if (snapshot.data.data == null ||
                    snapshot.data.data.isEmpty) {
                  return helper.empty(context);
                }
                return Container(
                  child: ListView.builder(itemBuilder: (context, index) {
                   /* if (index == snapshot.data.data.length) {
                      if (_bloc.canLoad) {
                        _bloc.f_loadMore();
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      else
                        return Container();
                    }*/
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: NetworkCard(data:snapshot.data.data[index] , type: widget.type,),
                    );
                  },
                    itemCount: snapshot.data.data.length + 0,
                    padding: const EdgeInsets.only(top: 16  , bottom: 16),
                  ),
                );
              }
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
   widget.bloc.getNetwork();
  }

  @override
  void retry() {
    widget.bloc.getNetwork();
  }
}
