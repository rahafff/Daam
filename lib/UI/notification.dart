import 'package:first_card_project/Bloc/notificationBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/notificationModel.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/notificationCard.dart';
import 'package:flutter/material.dart';

import 'BaseUI.dart';

class NotificationScreen extends BaseUI<NotyBloc> {
  @override
  _FAQState createState() => _FAQState();

  NotificationScreen():super(bloc:NotyBloc());

}

class _FAQState extends BaseUIState<NotificationScreen> {
  NotyBloc _bloc ;

  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context,AppLocalizations.of(context).trans("notification"));
  }

  @override
  Widget buildUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constrains) {
        return StreamBuilder<NotificationModel>(
            stream: _bloc.faqStream,
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
                      return NotificationCard(model: snapshot.data.data[index],);
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
    _bloc  = widget.bloc;
    _bloc.getNoty();
  }

  @override
  void retry() {
    _bloc.getNoty();
  }
}
