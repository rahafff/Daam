import 'package:first_card_project/Bloc/PrivacyPloicyBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/HtmlBodyModel.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../BaseUI.dart';

class PrivacyPolicyPage extends BaseUI<PrivacyPolicyBloc> {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();

  PrivacyPolicyPage() : super(bloc: PrivacyPolicyBloc());
}

class _PrivacyPolicyPageState extends BaseUIState<PrivacyPolicyPage> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context, AppLocalizations.of(context).trans("privacyPolicy"));
  }

  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<HtmlBodyModel>(
      stream: widget.bloc.privacyPolicyStream,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Html(
                  data: snapshot.data.data.body,
                  customTextAlign: (_) {
                    return TextAlign.start;
                  },
                  customTextStyle: (_, __) {
                    return __.copyWith(color: AppColors.white);
                  },
                ),
              ),
            ),
          );
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void init() {
    widget.bloc.getPrivacyPolicy();
  }
}
