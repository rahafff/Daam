import 'package:first_card_project/Bloc/AuthBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/UserDetails.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../DataStore.dart';

class UserDetails extends BaseUI<AuthBloc> {
  @override
  _UserDetailsState createState() => _UserDetailsState();

  UserDetails() : super(bloc: AuthBloc());
}

class _UserDetailsState extends BaseUIState<UserDetails> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context, AppLocalizations.of(context).trans("myAccount"));
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _gender = TextEditingController();

  FocusNode _nameFocus = FocusNode();

  int cityId;
  bool male, _isLoading = false;

  @override
  void dispose() {
    _name.dispose();
    _city.dispose();
    _phone.dispose();
    _email.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<UserDetailsModel>(
        stream: widget.bloc.userDetailsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.orange,
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: !edit,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              CustomAppButton(
                                color: AppColors.white,
                                borderRadius: 20,
                                elevation: 1,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                onTap: () {

                                  setState(() {
                                    edit = true;
                                  });
                                  _nameFocus.requestFocus();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 14,
                                      color: AppColors.orange,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).trans("edit"),
                                      style: AppTextStyle.mediumWhite
                                          .copyWith(color: AppColors.orange),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),

                            ],
                          ),
                          replacement: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 8,
                              ),

                              CustomAppButton(
                                color: AppColors.white,
                                borderRadius: 20,
                                elevation: 1,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                onTap: () {
                                  if (!validate()) return;
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  widget.bloc.updateUserDetails(
                                      name: _name.text,
                                      gender: gender.toString(),
                                      phone: _phone.text,
                                      email: _email.text,
                                      cityId: cityId.toString(),
                                      onData: (val) {
                                        if (val.message == "Success") {
                                          setState(() {
                                            _isLoading = false;
                                            edit = false;
                                          });
                                        }
                                      });
                                },
                                child: Row(
                                  children: [

                                    Text(
                                      AppLocalizations.of(context).trans("save"),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.mediumWhite
                                          .copyWith(color: AppColors.orange),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              CustomAppButton(
                                color: AppColors.white,
                                borderRadius: 20,
                                elevation: 1,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                onTap: () {
                                  _city.text = snapshot.data.data.city.name;
                                  cityId = snapshot.data.data.cityId;
                                  _name.text = snapshot.data.data.name;
                                  _phone.text = snapshot.data.data.phoneNumber;
                                  _email.text = snapshot.data.data.email;
                                  gender = snapshot.data.data.gender;
                                  male = gender == 1;
                                  _gender.text = getUserGender(male);
                                  setState(() {
                                    edit = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .trans("cancel"),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.mediumWhite
                                          .copyWith(color: AppColors.orange),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              border: Border.all(
                                color: AppColors.white,
                                width: 4
                              )
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.asset("assets/images/logo.png")),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  dataRow(
                      title: AppLocalizations.of(context).trans("name"),
                      controller: _name,
                      focusNode: _nameFocus),
                  dataRow(
                    title: AppLocalizations.of(context).trans("phone"),
                    controller: _phone,
                  ),
                  dataRow(
                    title: AppLocalizations.of(context).trans("email"),
                    controller: _email,
                    editable: false
                  ),
                  dataRow(
                      title: AppLocalizations.of(context).trans("city"),
                      controller: _city,
                      onTap: () {
                        if(edit)
                        helper.showCitySheet(context, onSelected: (name, id) {
                          _city.text = name;
                          cityId = id;
                        });
                      }),
                  edit?
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
                                    gender = male?1:2;
                                    _gender.text = getUserGender(male);
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
                                    gender = male?1:2;
                                    _gender.text = getUserGender(male);
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
                  ):
                  dataRow(
                      title: AppLocalizations.of(context).trans("gender"),
                      controller: _gender,
                      ),
                  SizedBox(
                    height: 8,
                  ),

                ],
              ),
            ),
          );
        });
  }

  int gender;

  @override
  void init() {
    widget.bloc.userDetails();
    widget.bloc.userDetailsStream.listen((event) {
      _email.text = event.data.email;
      _name.text = event.data.name;
      _phone.text = event.data.phoneNumber;
      _city.text = event.data.city.name;
      cityId = event.data.cityId;
      gender = event.data.gender;
      male = gender == 1;
      _gender.text = getUserGender(male);
    });
  }

  bool edit = false;

  getUserGender(bool isMale){
    return AppLocalizations.of(context).trans(isMale?"male":"female");
  }
  dataRow(
      {String title,
      TextEditingController controller,
      FocusNode focusNode,
      Function onTap,
        bool editable = true
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: AppTextStyle.normalWhiteBold,
          ),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          onTap: onTap,
          style: AppTextStyle.mediumWhite,
          readOnly: !edit || onTap != null || !editable ,
          maxLines: 1,
          decoration: InputDecoration(border: InputBorder.none),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
        )
      ],
    );
  }

  bool validate() {
    if (Utils.isTextEmpty(_name)) return emptyAlert('name');

    if (Utils.isTextEmpty(_phone)) return emptyAlert('phone');
    if (_phone.text.length < 8) {
      showErrorDialog(
          context, AppLocalizations.of(context).trans("invalidPhone"));
      return false;
    }
    if (_phone.text.length == 9 && _phone.text[0] != '9') {
      showErrorDialog(
          context, AppLocalizations.of(context).trans("invalidPhone"));
      return false;
    }
    if (_phone.text.length == 10 &&
        (_phone.text[0] != '0' || _phone.text[1] != '9')) {
      showErrorDialog(
          context, AppLocalizations.of(context).trans("invalidPhone"));
      return false;
    }

    if (Utils.isTextEmpty(_email)) return emptyAlert('email');
//    if(!EmailValidator.validate(_email.text.trim())){
//      showErrorDialog(context,  AppLocalizations.of(context).trans("invalidEmail"));
//      return false;
//    }
//    if(Utils.isTextEmpty(passwordController)) return emptyAlert('password');
//    if(passwordController.text.length < 8){
//      showErrorDialog(context, AppLocalizations.of(context).trans("lessThan6"));
//      return false;
//    }
//    if(passwordController.text != confPasswordController.text){
//      showErrorDialog(context, AppLocalizations.of(context).trans("passwordsNotMatch"));
//      return false;
//    }
    // if(male == null) return chooseAlert('gender');
    if (cityId == null) return chooseAlert('city');

    return true;
  }

  showToast(String name) {}

  bool emptyAlert(String key) {
    if (dataStore.lang == 'ar') {
      showErrorDialog(
          context,
          AppLocalizations.of(context).trans("empty") +
              AppLocalizations.of(context).trans(key));
    } //AppLocalizations.of(context).trans(key)+AppLocalizations.of(context).trans("empty")
    else
      showErrorDialog(
          context,
          AppLocalizations.of(context).trans(key) +
              AppLocalizations.of(context).trans("empty"));
    return false;
  }

  bool chooseAlert(String key) {
    showErrorDialog(
        context,
        AppLocalizations.of(context).trans("pleaseChoose") +
            AppLocalizations.of(context).trans(key));
    return false;
  }
}
