//import 'package:flutter/material.dart';
//
//import 'CircleIconButton.dart';
//
//class AppBottomBar extends StatefulWidget {
//  Function onItemChanged;
//
//  AppBottomBar(this.onItemChanged);
//
//  @override
//  _AppBottomBarState createState() => _AppBottomBarState();
//}
//
//class _AppBottomBarState extends State<AppBottomBar> {
//  int index = 0;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 70,
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
//        color: AppColors.white,
//      ),
//      //padding: const EdgeInsets.only(right: 8, left: 8, top: 15, bottom: 4),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        mainAxisSize: MainAxisSize.max,
//        children: <Widget>[
//          CircleIconButton(
//            function: () {
//              widget.onItemChanged(0);
//              setState(() {
//                index = 0;
//              });
//            },
//            icon: "assets/images/home_icon.png",
//            category: AppLocalizations.of(context).trans("home"),
//            color: AppColors.white,
//            clicked: index == 0,
//          ),
//          CircleIconButton(
//            function: () {
////                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notifications()));
//              widget.onItemChanged(1);
//              setState(() {
//                index = 1;
//              });
//            },
//            icon: "assets/images/notification_icon.png",
//            category: AppLocalizations.of(context).trans("notification"),
//            color: AppColors.white,
//            clicked: index == 1,
//          ),
//          CircleIconButton(
//            function: () {
//              widget.onItemChanged(2);
//              setState(() {
//                index = 2;
//              });
//              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Services()));
//            },
//            icon: "assets/images/favorite_icon.png",
//            category: AppLocalizations.of(context).trans("favorite"),
//            color: AppColors.white,
//            clicked: index == 2,
//          ),
//          CircleIconButton(
//            function: () {
//              widget.onItemChanged(3);
//              setState(() {
//                index = 3;
//              });
//            },
//            icon: "assets/images/settings_icon.png",
//            category: AppLocalizations.of(context).trans("settings"),
//            color: AppColors.white,
//            clicked: index == 3,
//          ),
//
//
//
//        ],
//      ),
//    );
//  }
//}
