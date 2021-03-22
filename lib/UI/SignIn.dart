import 'package:email_validator/email_validator.dart';
import 'package:first_card_project/Bloc/AuthBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../DataStore.dart';
import 'BaseUI.dart';
import 'Home.dart';

class SignIn extends BaseUI<AuthBloc> {

  final String type;

  @override
  _SignInState createState() => _SignInState();

  SignIn({this.type = "User"}):super(bloc:AuthBloc());
}

class _SignInState extends BaseUIState<SignIn> {
  FocusNode userName = FocusNode();
  FocusNode password = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool  _isLoading = false;
  @override
  AppBar buildAppBar() {
    // TODO: implement buildAppBar
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBlack,
    );
  }

  @override
  Widget buildUI(BuildContext context) {
    // TODO: implement buildUI
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                '${AppLocalizations.of(context).trans("login")}\n${AppLocalizations.of(context).trans("welcome")}',
                style: AppTextStyle.largeWhiteBold.copyWith(fontFamily: AppTextStyle.cairo),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    helper.getTextField(emailController, false, userName, password,AppLocalizations.of(context).trans('email'),inputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 8,
                    ),
                    helper.getTextField(passwordController, true, password, null,AppLocalizations.of(context).trans('password')),
                 SizedBox(height: 8,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: InkWell(
                     onTap: (){

                       Utils.lunchURL(widget.type == "User"?"http://daamcard.sy/forgetPassword/1":"http://daamcard.sy/forgetPassword/2");
                     },
                     child: Text(
                       AppLocalizations.of(context).trans("forgetPassword"),
                       style: AppTextStyle.smallWhite,
                     ),
                   ),
                 ),
                    SizedBox(height: 24,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: CustomAppButton(
                        child: Text(
                          AppLocalizations.of(context).trans("login"),
                          style: AppTextStyle.mediumWhiteBold,
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        borderRadius: 50,
                        color: AppColors.cyan,
                        onTap: () {
                          if(!validate()) return;
                          setState(() {
                            _isLoading = true;
                          });
                          widget.bloc.login(
                            phone: emailController.text,
                            password: passwordController.text,
                            type: widget.type,
                            onData: (val){
                              setState(() {
                                _isLoading = false;
                              });
                              if(val.code == 200)
                              {
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                    builder: (context) => Home()
                                ),(route){
                                  return false;
                                });
                              }
                              else showErrorDialog(context, val.message??'');
                            }
                          );


                        },
                        elevation: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
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
    );
  }

  @override
  void init() {
    // TODO: implement init
  }


  bool validate(){
    if(Utils.isTextEmpty(emailController)) return emptyAlert('email');
    if(!EmailValidator.validate(emailController.text)) {
      showErrorDialog(context,AppLocalizations.of(context).trans("invalidEmail"));
      return false;
    }
//    if(passwordController.text.length < 8){
//      Fluttertoast.showToast(msg: AppLocalizations.of(context).trans("invalidPhone"));
//      return false;
//    }
//    if(passwordController.text.length == 9 && passwordController.text[0]!='9'){
//      Fluttertoast.showToast(msg: AppLocalizations.of(context).trans("invalidPhone"));
//      return false;
//    }
//    if(passwordController.text.length == 10 && (passwordController.text[0]!='0' || passwordController.text[1]!='9')){
//      Fluttertoast.showToast(msg: AppLocalizations.of(context).trans("invalidPhone"));
//      return false;
//    }
    if(Utils.isTextEmpty(passwordController)) return emptyAlert('password');
    if(passwordController.text.length < 6){
      showErrorDialog(context, AppLocalizations.of(context).trans("lessThan6"));
      return false;
    }
    return true;

  }
  bool emptyAlert(String key)
  {
    if(dataStore.lang == 'ar')
    {
      showErrorDialog(context, AppLocalizations.of(context).trans("empty")+AppLocalizations.of(context).trans(key));
    }
    else showErrorDialog(context, AppLocalizations.of(context).trans(key)+AppLocalizations.of(context).trans("empty"));
    return false;
  }
}
