import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/BusinessTypeModel.dart';
import 'package:first_card_project/Models/CitiesModel.dart';
import 'package:first_card_project/Models/NetworksModel.dart';
import 'package:first_card_project/UI/ServiceProviders/SearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperWidgets {
  Widget getTextField(
          controller, obscure, fNode, FocusNode nNode, String hint , {bool readOnly = false , Function onTap , TextInputType inputType = TextInputType.text , int maxLines = 1}) =>
      Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 0.5,
                  offset: Offset(0, 6))
            ]),
        child: TextFormField(
//          autovalidate: true,
          readOnly: readOnly,
          keyboardType: inputType,
          maxLines: maxLines,
          onTap: onTap,
          controller: controller,
          focusNode: fNode,
          onFieldSubmitted: (val) {
            if (nNode != null) nNode.requestFocus();
          },
          style: AppTextStyle.mediumBlack,
          obscureText: obscure,
//    cursorRadius: Radius.circular(0.7),
//    cursorColor: Color.fromARGB(255, 52, 138, 192),
          validator: (val) {
            return;
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              border: InputBorder.none,
              labelText: hint,
              labelStyle: AppTextStyle.mediumBlack),
        ),
      );

  background(BuildContext context, {bool hasTop = true}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: height - (hasTop ? MediaQuery.of(context).padding.top + 50 : 0),
        width: width,
        alignment: Alignment.bottomCenter,
        color: AppColors.white,
        child: Image.asset(
          'assets/images/background.png',
          width: width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  mainAppBar(BuildContext context, String title, {bool showSettings = true}) =>
      AppBar(
       actions: <Widget>[
         Padding(
           padding: EdgeInsets.all(8),
           child: Visibility(
             visible: showSettings,
             child: GestureDetector(
                 onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchPage()));
                 },
                 child: Icon(
                   Icons.search_sharp,
                   size: 24,
                   color: AppColors.white,
                 )),
           ),
         ),
       ],
        title: Text(
          title,
          style: AppTextStyle.normalWhiteBold.copyWith(fontWeight: FontWeight.bold/*,color: AppColors.orange*/ ),
        ),
        backgroundColor: AppColors.lightBlack,
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: AppColors.white),
      );


//
//  navigateToRoute(
//      {@required context, @required UserType userType, WidgetBuilder builder}) {
//    if (userType == UserType.GUEST_DIALOG) {
//      showDialog(
//          context: context,
//          builder: (context) {
//            return Dialog(
//              child: Container(
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Column( mainAxisSize: MainAxisSize.min,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      SizedBox(
//                        height: 25,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                        child: Text(
//                          AppLocalizations.of(AppConstant.context)
//                              .trans('please_login_to_continue'),
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                              color: AppColors.black,
//                              fontWeight: FontWeight.w400,
//                              fontSize: 18),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(
//                            top: 8.0, left: 35, right: 35),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            InkWell(
//                              onTap: () {
//                                Navigator.pop(context);
//                              },
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Text(
//                                  AppLocalizations.of(AppConstant.context)
//                                      .trans("no"),
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      color: AppColors.textDark, fontSize: 21),
//                                ),
//                              ),
//                            ),
//                            Text(
//                              '|',
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: 21, color: AppColors.textDark),
//                            ),
//                            InkWell(
//                              onTap: () {
//                                Navigator.of(context).pushAndRemoveUntil(
//                                    MaterialPageRoute(
//                                        builder: (context) => MyApp()),
//                                    ModalRoute.withName('/sign'));
//                              },
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Text(
//                                  AppLocalizations.of(AppConstant.context)
//                                      .trans("yes"),
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      color: AppColors.pink, fontSize: 21),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            );
//          });
//    } else if (userType == UserType.LoggedIn) {
//      Navigator.of(context).push(MaterialPageRoute(builder: builder));
//    }
//  }

//  navigateToLoginIfNotAuthorized(context) {
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      //TODO  add GSM Page
////      Navigator.of(context).pushAndRemoveUntil(
////          MaterialPageRoute(builder: (context) => CheckGsmPage()),
////          ModalRoute.withName('/sign'));
//    });
//  }

//  getGeneralDialog(
//      {context,
//      translatedText,
//      positiveTranslatedText,
//      negativeTranslatedText,
//      positiveFunction,
//      negativeFunction = null}) {
//    showDialog(
//        context: context,
//        builder: (context) {
//          return Dialog(
//            child: Container(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    SizedBox(
//                      height: 25,
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                      child: Text(
//                        AppLocalizations.of(context)
//                            .trans(translatedText),
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            color: AppColors.black,
//                            fontWeight: FontWeight.w400,
//                            fontSize: 18),
//                      ),
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Padding(
//                      padding:
//                          const EdgeInsets.only(top: 8.0, left: 35, right: 35),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          InkWell(
//                            onTap: negativeFunction == null
//                                ? () {
//                                    Navigator.pop(context);
//                                  }
//                                : negativeFunction,
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text(
//                                AppLocalizations.of(context)
//                                    .trans(negativeTranslatedText),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: AppColors.textDark, fontSize: 21),
//                              ),
//                            ),
//                          ),
//                          Text(
//                            '|',
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 21, color: AppColors.textDark),
//                          ),
//                          InkWell(
//                            onTap: () {
//                              Navigator.pop(context);
//                              positiveFunction();
//                            },
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text(
//                                AppLocalizations.of(context)
//                                    .trans(positiveTranslatedText),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: AppColors.pink, fontSize: 21),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          );
//        });
//  }

//  logout(BuildContext context){
//    showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          content: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Text(
//                AppLocalizations.of(context)
//                    .trans('areYouSure'),
//                style: AppTextStyle.smallBlackBold,
//                textAlign: TextAlign.center,
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              CustomAppButton(
//                margin: EdgeInsets.symmetric(vertical: 10),
//                child: Text(
//                  AppLocalizations.of(context).trans('logout'),
//                  style: AppTextStyle.smallRed,
//                ),
//                onTap: () {
////                                  showDialog(
////                                    barrierDismissible: false,
////                                    context: context,
////                                    builder: (context) => WillPopScope(
////                                      onWillPop: () async => false,
////                                      child: Center(
////                                        child: CircularProgressIndicator(),
////                                      ),
////                                    ),
////                                  );
//                  bloc.f_logout(context,({GeneralResponse val, error}) {
//                    //Navigator.of(context).pop();
//                    print(val);
//                    if (error != null) {
//                      Fluttertoast.showToast(
//                          msg: error.toString());
//                    } else if (val != null &&
//                        val.code != -23 &&
//                        val.code < 0) {
//                      Fluttertoast.showToast(
//                          msg: error.toString());
//                    } else {
//                      dataStore.setUser(null).then((cal) {
//                        Navigator.of(context)
//                            .pushAndRemoveUntil(
//                            MaterialPageRoute(
//                              builder: (context) =>
//                                  MyApp(),
//                            ),
//                                (Route<dynamic> route) => false);
//                      });
//                    }
//                  });
//                },
//                padding: EdgeInsets.all(8),
//                color: AppColors.white,
//                borderRadius: 5,
//                border: BorderSide(
//                    color: AppColors.deepGray,
//                    width: 1,
//                    style: BorderStyle.solid),
//              )
//            ],
//          ),
//        );
//      },
//    );
//  }
  showCitySheet(BuildContext context,
      {@required onSelected(String cityName , int cityId) , bool optional = false}) {
    genBloc.f_getCities();
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.lightGray,
        builder: (context) => StreamBuilder<CitiesModel>(
            stream: genBloc.citiesStream,
            builder: (context, snapshot) {
              if(!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                child: ListView.builder(
                    itemCount: snapshot.data.data.length +(optional?1:0),
                    shrinkWrap: true,
                    itemBuilder: (context,index){

                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          if(optional && index == snapshot.data.data.length){
                            onSelected(null , null);
                          }
                          else onSelected(snapshot.data.data[index].name , snapshot.data.data[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 8.0,
                              bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${(optional && index == snapshot.data.data.length)?AppLocalizations.of(context).trans("notSelected") : snapshot.data.data[index].name}'),
                            ],
                          ),
                        ),
                      );

                    }),
              );
            }
        ));
  }

  showNetworkSheet(BuildContext context,
      {@required onSelected(String networkName , int networkId), bool optional = false}) {
    genBloc.f_getNetworks();
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.lightGray,
        builder: (context) => StreamBuilder<NetworkModel>(
            stream: genBloc.networksStream,
            builder: (context, snapshot) {
              if(!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                child: ListView.builder(
                    itemCount: snapshot.data.data.length+(optional?1:0),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          if(optional && index == snapshot.data.data.length){
                            onSelected(null , null);
                          }
                          else onSelected(snapshot.data.data[index].name , snapshot.data.data[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 8.0,
                              bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${(optional && index == snapshot.data.data.length)?AppLocalizations.of(context).trans("notSelected") :snapshot.data.data[index].name}'),
                            ],
                          ),
                        ),
                      );

                    }),
              );
            }
        ));
  }

  var lastNetworkId;
  showBusinessTypesSheet(BuildContext context,networkId,
      {@required onSelected(String networkName , int networkId),bool refresh = false, bool optional = false}) {
    if(refresh){
      genBloc.refreshBusiness();
    }
    if(lastNetworkId != networkId || refresh)
      {
        lastNetworkId = networkId;
        genBloc.f_getBusiness(networkId);
      }
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.lightGray,
        builder: (context) => StreamBuilder<BusinessTypeModel>(
            stream: genBloc.businessTypeStream,
            builder: (context, snapshot) {
              if(!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                child: ListView.builder(
                    itemCount: snapshot.data.data.length+(optional?1:0),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          if(optional && index == snapshot.data.data.length){
                            onSelected(null , null);
                          }
                          else
                          onSelected(snapshot.data.data[index].name , snapshot.data.data[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 8.0,
                              bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${(optional && index == snapshot.data.data.length)?AppLocalizations.of(context).trans("notSelected") :snapshot.data.data[index].name}'),
                            ],
                          ),
                        ),
                      );

                    }),
              );
            }
        ));
  }

  showReservedSheet(BuildContext context,
      {@required onSelected(String networkName , int networkId), bool optional = false}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.lightGray,
        builder: (context) => ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          child: ListView.builder(
              itemCount: 2+(optional?1:0),
              shrinkWrap: true,
              itemBuilder: (context,index){

                return InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    if(optional && index == 2){
                      onSelected(null , null);
                    }
                    else onSelected((index == 0 ?AppLocalizations.of(context).trans("unreserved"):AppLocalizations.of(context).trans("reserved")) , index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                        bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            '${(optional && index == 2)?AppLocalizations.of(context).trans("notSelected") :(index == 0 ? AppLocalizations.of(context).trans("unreserved"):AppLocalizations.of(context).trans("reserved"))}'),
                      ],
                    ),
                  ),
                );

              }),
        ));
  }



  empty(BuildContext context){
    return Container();
  }


}

final helper = HelperWidgets();
