import 'package:first_card_project/Helper/NotificationHelper.dart';
import 'package:first_card_project/UI/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Bloc/GeneralBloc.dart';
import 'DataStore.dart';
import 'Helper/AppColors.dart';
import 'Localization/AppLocal.dart';
import 'UI/AppWrapper.dart';
import 'UI/StartPage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

//  dataStore.getFacebookCredentials();
//  dataStore.getLinkedInCredentials();
//  dataStore.getTelegramCredentials();

  notificationHelper.firebaseCloudMessaging_Listeners();
  await dataStore.getUser();
  await dataStore.getLang();

  //if(DateTime.now().isBefore(DateTime.parse("2021-01-15T09:17:09.000000Z")))
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: genBloc.langStream,
        initialData: dataStore.lang,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Damm Card',
            navigatorKey: genBloc.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: AppColors.blue,
              backgroundColor: AppColors.lightBlack,
              accentColor: AppColors.orange,
              scaffoldBackgroundColor: AppColors.lightBlack, //background,
              appBarTheme: AppBarTheme(
                color: AppColors.white
              ),
              fontFamily: 'Cairo'
            ),
            home: AppWrapper(),
           // MyHomePage(title: "asdasd",),
           // AddNewPost(),
            locale: Locale(snapshot.data),
            supportedLocales: [const Locale('ar'), const Locale('en')],
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
          );
        });
  }
}