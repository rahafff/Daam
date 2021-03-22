import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:flutter/material.dart';

import '../DataStore.dart';

Future<T> showErrorDialog<T>(BuildContext context,String msg,{bool isError = true}) async{

  return await showDialog<T>(context: context , builder: (context){
    return AlertDialog(
      title: Text(msg??AppLocalizations.of(context).trans("wrong") , style: AppTextStyle.normalBlackBold.copyWith(color:isError? AppColors.red:AppColors.black),),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppButton(
            elevation: 0,
            onTap: (){
              Navigator.of(context).pop(true);
            },
            child: Text(AppLocalizations.of(context).trans("ok"),style: AppTextStyle.normalBlackBold,),
          ),
        ],
      ),
    );
  },barrierDismissible: false,);
}



Future<T> showChangeLanguageDialog<T>(BuildContext context) async{

  return await showDialog<T>(context: context , builder: (context){
    return AlertDialog(
      title: Text(AppLocalizations.of(context).trans("language") , style: AppTextStyle.normalBlackBold ,textAlign: TextAlign.center,),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppButton(
            elevation: 0,
          color: AppColors.white,
            onTap: (){
              if(dataStore.lang == "en"){
                genBloc.f_changeLang("ar");
                Navigator.of(context).pop(true);
              }
            },
            child: Text(AppLocalizations.of(context).trans("arabic"),style: AppTextStyle.normalBlackBold.copyWith(
              color: dataStore.lang == 'ar'? AppColors.black : AppColors.gray194
            ),),
          ),
          SizedBox(width: 16,),
          CustomAppButton(
            elevation: 0,
            color: AppColors.white,
            onTap: (){
              if(dataStore.lang == "ar"){
                genBloc.f_changeLang("en");
                Navigator.of(context).pop(true);
              }
            },
            child: Text(AppLocalizations.of(context).trans("english"),style: AppTextStyle.normalBlackBold.copyWith(
                color: dataStore.lang == 'en'? AppColors.black : AppColors.gray194
            ),),
          ),
        ],
      ),
    );
  });
}