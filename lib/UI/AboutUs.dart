import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/SocialLinksModel.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/SocialLinksWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(context, AppLocalizations.of(context).trans("aboutUs")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<SocialLinksModel>(
          stream: genBloc.socialStream,
          builder: (context, snapshot) {
            if(snapshot.hasData)
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png" , fit: BoxFit.cover,),
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Html(
                        data: snapshot.data.data.description??"",
                        customTextAlign: (_) {
                          return TextAlign.center;
                        },
                        customTextStyle: (_, __) {
                          return __.copyWith(color: AppColors.white);
                        },
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(AppLocalizations.of(context).trans("contactUs") , style: AppTextStyle.mediumWhiteBold,),
                    ),
                    SizedBox(height: 16,),
                    SocialLinksWidget(),
                  ],
                ),
              );
            return Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }

  @override
  void initState() {
    genBloc.getSocialLinks();
    super.initState();
  }
}
