import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:email_validator/email_validator.dart';
import 'package:first_card_project/Bloc/AuthBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../DataStore.dart';
import 'BaseUI.dart';
import 'SignIn.dart';

class SignUp extends BaseUI<AuthBloc> {
  @override
  _SignUpState createState() => _SignUpState();

  SignUp():super(bloc:AuthBloc());


}

class _SignUpState extends BaseUIState<SignUp> {

  FocusNode userName = FocusNode();
  FocusNode password = FocusNode();
  FocusNode confPassword = FocusNode();
  FocusNode email = FocusNode();
  FocusNode phone = FocusNode();

  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  int cityId;
  bool male,_isLoading= false;
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, "");
  }

  @override
  Widget buildUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                Text(
                  '${AppLocalizations.of(context).trans("signUp")}',
                  style: AppTextStyle.largeWhiteBold.copyWith(fontFamily: AppTextStyle.segoePrint),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      helper.getTextField(userNameController, false, userName, phone,AppLocalizations.of(context).trans('name')),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(phoneController, false, phone, email,AppLocalizations.of(context).trans('phone'),inputType: TextInputType.phone),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(emailController, false, email, password,AppLocalizations.of(context).trans('email')),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(passwordController, true, password, confPassword,AppLocalizations.of(context).trans('password')),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(confPasswordController, true, confPassword, null,AppLocalizations.of(context).trans('confPassword'),readOnly: false),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(cityController, false, null, null,AppLocalizations.of(context).trans('city') , readOnly: true,onTap: (){
                        helper.showCitySheet(context, onSelected: (name,id){
                          cityController.text = name;
                          cityId = id;
                        });
                      },),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context).trans("gender") , style: AppTextStyle.mediumWhite,),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(value: male??false, onChanged: (val){
                                      setState(() {
                                        male=val;
                                      });
                                    }),
                                    SizedBox(width: 4,),
                                    Text(AppLocalizations.of(context).trans("male") , style: AppTextStyle.smallWhite,)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(value: !(male??true), onChanged: (val){
                                      setState(() {
                                        male=!val;
                                      });
                                    }),
                                    SizedBox(width: 4,),
                                    Text(AppLocalizations.of(context).trans("female") , style: AppTextStyle.smallWhite,)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 24,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: CustomAppButton(
                          child: Text(
                            AppLocalizations.of(context).trans("signUp"),
                            style: AppTextStyle.mediumWhiteBold,
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          borderRadius: 50,
                          color: AppColors.orange,
                          onTap: () async {

                            if(!validate()) return;

                            setState(() {
                              _isLoading = true;
                            });

                            DeviceInfoPlugin device = DeviceInfoPlugin();
                            String serial;
                            if(Platform.isIOS)
                              {
                                IosDeviceInfo iosInfo = await device.iosInfo;
                                serial = iosInfo.identifierForVendor;
                              }
                            else serial = (await device.androidInfo).androidId;



                            widget.bloc.signUp(
                              name: userNameController.text,
                              gender: male?1:2,
                              phone: phoneController.text,
                              email: emailController.text,
                              cityId: cityId,
                              password: passwordController.text,
                              serialNumber: serial,
                              onData: (GeneralModel val){

                                setState(() {
                                  _isLoading = false;
                                });

                                if(val.code == 200)
                                  {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => SignIn()
                                    ));
                                  }
                                else showErrorDialog(context, val.message,isError: false);
                              }
                            );
                          },
                          elevation: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      AppLocalizations.of(context).trans("privacyTerms"),
                      style: AppTextStyle.mediumBlue,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void init() {
    // TODO: implement init
  }

  bool validate(){

    if(Utils.isTextEmpty(userNameController)) return emptyAlert('name');

    if(Utils.isTextEmpty(phoneController)) return emptyAlert('phone');
    if(phoneController.text.length < 8){
      showErrorDialog(context,  AppLocalizations.of(context).trans("invalidPhone"));
      return false;
    }
    if(phoneController.text.length == 9 && phoneController.text[0]!='9'){
      showErrorDialog(context, AppLocalizations.of(context).trans("invalidPhone"));
      return false;
    }
    if(phoneController.text.length == 10 && (phoneController.text[0]!='0' || phoneController.text[1]!='9')){
      showErrorDialog(context, AppLocalizations.of(context).trans("invalidPhone"));
      return false;
    }

    if(Utils.isTextEmpty(emailController)) return emptyAlert('email');
//    if(!EmailValidator.validate(emailController.text.trim())){
//      showErrorDialog(context,  AppLocalizations.of(context).trans("invalidEmail"));
//      return false;
//    }
    if(Utils.isTextEmpty(passwordController)) return emptyAlert('password');
    if(passwordController.text.length < 8){
      showErrorDialog(context, AppLocalizations.of(context).trans("lessThan6"));
      return false;
    }
    if(passwordController.text != confPasswordController.text){
      showErrorDialog(context, AppLocalizations.of(context).trans("passwordsNotMatch"));
      return false;
    }
    if(male == null) return chooseAlert('gender');
    if(cityId == null) return chooseAlert('city');

    return true;

  }

  showToast(String name){

  }
  bool emptyAlert(String key)
  {
    if(dataStore.lang == 'ar')
    {
      showErrorDialog(context, AppLocalizations.of(context).trans("empty")+AppLocalizations.of(context).trans(key));
    }//AppLocalizations.of(context).trans(key)+AppLocalizations.of(context).trans("empty")
    else showErrorDialog(context, AppLocalizations.of(context).trans(key)+AppLocalizations.of(context).trans("empty"));
    return false;
  }
  bool chooseAlert(String key)
  {

    showErrorDialog(context, AppLocalizations.of(context).trans("pleaseChoose")+AppLocalizations.of(context).trans(key));
    return false;
  }
  @override
  void dispose() {
    phoneController.dispose();
    phone.dispose();
    userName.dispose();
    userNameController.dispose();
    password.dispose();
    passwordController.dispose();
    confPassword.dispose();
    confPasswordController.dispose();
    email.dispose();
    emailController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
