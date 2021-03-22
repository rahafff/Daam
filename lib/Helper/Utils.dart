import 'dart:convert';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/ArabicLocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:image_picker/image_picker.dart';

class Utils {

//  static multiImagesSelector(callBack(List<Asset> resultImages)){
//    List<Asset> _images = List();
//    MultiImagePicker.pickImages(
//      maxImages: 10,
//      enableCamera: true,
//      selectedAssets: _images,
//      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//      materialOptions: MaterialOptions(
////        actionBarColor: "#000000",
//        actionBarTitle: "All Photos",
//        allViewTitle: "All Photos",
////        actionBarTitleColor: "#000000",
//        useDetailsView: false,
////                                          selectCircleStrokeColor: "#000000",
//      ),
//    ).then((images){
//      callBack(images);
//    });
//  }
//  static final _picker = ImagePicker();
//  static imageSelectorGallery(callBack(File galleryFile)) async {
//    var galleryFile = await _picker.getImage(source: ImageSource.gallery);
//    if(galleryFile !=null)
//    callBack(File(galleryFile.path));
//  }
//
//  static Future<void> checkPhone(String phone ,cb) async {
//    try {
//      if(phone.isEmpty) return ;
//      PhoneNumber _plugin = PhoneNumber();
//      var parsed = await _plugin.parse(phone);
//      cb(val:parsed['e164']);
//    } on PlatformException catch (error) {
//      cb(error:error.message);
//    }
//  }

//  uploadPhoto() {}
//
//  static videoSelectorGallery(callBack(File videoFile)) async {
//    File videoFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
//    callBack(videoFile);
//  }
//

//  static cropImage(context,String filePath,callBack(File file)){
//    ImageCropper.cropImage(
//        sourcePath: filePath,
//        aspectRatioPresets: [
//          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
//        ],
//        androidUiSettings: AndroidUiSettings(
//            toolbarTitle:'',// AppLocalizations.of(context).trans("editPhoto"),
//            toolbarColor: AppColors.black,
//            toolbarWidgetColor: Colors.white,
//            initAspectRatio: CropAspectRatioPreset.original,
//            lockAspectRatio: false),
//        iosUiSettings: IOSUiSettings(
//          minimumAspectRatio: 1.0,
//        )
//    ).then((file){
//      callBack(file);
//    });
//  }
//
//  static asyncCropImage(context,String filePath)async{
//    File file = await ImageCropper.cropImage(
//        sourcePath: filePath,
//        aspectRatioPresets: [
//          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
//        ],
//        androidUiSettings: AndroidUiSettings(
//            toolbarTitle:'',// AppLocalizations.of(context).trans("editPhoto"),
//            toolbarColor: AppColors.black,
//            toolbarWidgetColor: Colors.white,
//            initAspectRatio: CropAspectRatioPreset.original,
//            lockAspectRatio: false),
//        iosUiSettings: IOSUiSettings(
//          minimumAspectRatio: 1.0,
//        )
//    );
//
//    return file;
//  }
//
//
//

  static lunchURL(url) async {
    //String url = 'mailto:${email}?subject=New&body=New';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
//      throw 'Could not launch $url';
    }
  }
//  static lunchPhoneService(phone) async {
//    String url = 'tel:${phone}';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
//
//  static checkConnect()
//  async {
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.mobile) {
//      return true;
//    } else if (connectivityResult == ConnectivityResult.wifi) {
//      return true;
//    }
//    return false;
//
//  }

   static bool isTextEmpty(TextEditingController controller){
    return controller.text.trim().isEmpty;
  }
  static String getTime(DateTime date){

    if(date == null) return '';

    date = date.toLocal();
    return formatDate(date, [hh,':',nn,' ' , am],locale:dataStore.lang == "ar"?const ArabicLocale():const EnglishLocale());
  }

  static String getDate(DateTime date){
    if(date == null) return '';

    date = date.toLocal();
    return formatDate(date, [dd,' ',MM,' ',yyyy],locale:dataStore.lang == "ar"?const ArabicLocale():const EnglishLocale());
  }
}
