import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:first_card_project/Widget/MapView.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../DataStore.dart';
class AddServiceProvider extends BaseUI<ServiceProvidersBloc> {
  @override
  _AddServiceProviderState createState() => _AddServiceProviderState();
  AddServiceProvider():super(bloc: ServiceProvidersBloc());
}

class _AddServiceProviderState extends State<AddServiceProvider> {
  FocusNode userName = FocusNode();
  FocusNode password = FocusNode();
  FocusNode confPassword = FocusNode();
  FocusNode network = FocusNode();

  FocusNode email = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode desc = FocusNode();
  FocusNode businessName = FocusNode();
  FocusNode location = FocusNode();

  TextEditingController phoneController = TextEditingController();
  TextEditingController networkController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController latLngController = TextEditingController();

  int cityId,networkId,businessTypeId;
  bool male,_isLoading= false;

  double myLat,myLng;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(context, AppLocalizations.of(context).trans("joinUs")),
      body: ModalProgressHUD(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      helper.getTextField(userNameController, false, userName, businessName,AppLocalizations.of(context).trans('name')),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(businessNameController, false, businessName, phone,AppLocalizations.of(context).trans('businessName')),
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
                      helper.getTextField(locationController, false, location, null,AppLocalizations.of(context).trans('address'),readOnly: false),

                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(latLngController, false, null, null,AppLocalizations.of(context).trans('location'),readOnly: true , onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return MapView(onChanged: (lat,lng){
                            myLat = lat;
                            myLng = lng;
                            latLngController.text = lat.toString() + "," + lng.toString();
                          },);
                        }));
                      }),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(networkController, false, null, null,AppLocalizations.of(context).trans('network') , readOnly: true,onTap: (){
                        helper.showNetworkSheet(context, onSelected: (name,id){
                          networkController.text = name;
                          networkId = id;
                          businessTypeController.text ="";
                          businessTypeId = null;
                        });
                      },),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(businessTypeController, false, null, null,AppLocalizations.of(context).trans('businessType') , readOnly: true,onTap: (){
                        if(networkId == null) return;
                        helper.showBusinessTypesSheet(context, networkId.toString(),onSelected: (name,id){
                          businessTypeController.text = name;
                          businessTypeId = id;
                        },refresh: true);
                      },),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(descController, false, desc, null,AppLocalizations.of(context).trans('description')),

                      SizedBox(height: 24,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: CustomAppButton(
                          child: Text(
                            AppLocalizations.of(context).trans("joinUs"),
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

                            ServiceProvidersBloc().joinUsAsServiceProvider(
                                name: userNameController.text,
                                phoneNumber: phoneController.text,
                                email: emailController.text,
                                cityId: cityId.toString(),
                                password: passwordController.text,
                                networkId: networkId.toString(),
                                location: locationController.text,
                                businessName: businessNameController.text,
                                businessTypeId: businessTypeId.toString(),
                                description: descController.text,
                                latitude: myLat.toString(),
                                longitude: myLng.toString(),
                                onData: (GeneralModel val) async {

                                  setState(() {
                                    _isLoading = false;
                                  });

                                  if(val.code == 200)
                                  {
                                    await showErrorDialog(context, AppLocalizations.of(context).trans("joinSuccess"),isError: false);
                                    Navigator.of(context).pop();
                                  }
                                  else showErrorDialog(context, val.message);
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
          )
        ),
      ),
    );
  }

  bool validate(){

    if(Utils.isTextEmpty(userNameController)) return emptyAlert('name');
    if(Utils.isTextEmpty(businessNameController) )return emptyAlert('businessName');

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
    if(cityId == null) return chooseAlert('city');
    if(Utils.isTextEmpty(locationController)) return emptyAlert('address');
    if(myLat == null){
      return chooseAlert('location');
    }
    if(networkId == null) return chooseAlert('network');
    if(businessTypeId == null) return chooseAlert('businessType');
    if(Utils.isTextEmpty(descController)) return emptyAlert('description');
    return true;

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
