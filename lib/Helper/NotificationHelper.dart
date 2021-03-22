import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  String token;

  Future onSelectNotification(String payload) {
    print(payload);
  }

  showNotification(Map<String, dynamic> msg) async {
    //print("ghv ghv: $msg");
    var android = new AndroidNotificationDetails(
        "1", "Channel Name", "Channel description",styleInformation: BigTextStyleInformation(''));
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
//    print(msg['notification']['body']);
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin.show(
        0,
        (msg['Title']),
        (msg['Body']),
        platform,
      ).then((val){

        print("success");
      }).catchError((e){
        print("error " + e.toString());
      });

    }

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.show(0, (msg['notification']['title']),
          (msg['notification']['body']), platform,
          payload: '');
    }
  }
  void firebaseCloudMessaging_Listeners(/*BuildContext context*/) {
    print('firebaseCloudMessaging_Listeners');

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin
        .initialize(platform, onSelectNotification: onSelectNotification)
        .then((v) {
      //showNotification(message);
    });
     _firebaseMessaging.getToken().then((token) {
       print('Token: $token');
       this.token = token;
       //todo: call update token API
//        bloc.f_updateToken(context,token,(val){
//          if(val == null)
//            Fluttertoast.showToast(msg: AppLocalizations.of(context).trans('noConnection'));
//          else if(val.code <= 0)
//            Fluttertoast.showToast(msg: val.errorMsg);
//
//        });
     });

      _firebaseMessaging.onTokenRefresh.listen((token) {
        this.token = token;
        print('Token: $token');
        genBloc.updateToken(token);
        //todo: call update token API
//        bloc.f_updateToken(context,token,(val){
//          if(val == null)
//            Fluttertoast.showToast(msg: AppLocalizations.of(context).trans('noConnection'));
//          else if(val.code <= 0)
//            Fluttertoast.showToast(msg: val.errorMsg);
//
//        });
      });


    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('_firebaseMessaging onMessage');
        showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('_firebaseMessaging onResume');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('_firebaseMessaging onLaunch');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}

final notificationHelper = NotificationHelper();