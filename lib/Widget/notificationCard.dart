import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Models/notificationModel.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotiData model;
  const NotificationCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: AppColors.green , ),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white /*.withOpacity(0.01)*/
        ),
        child: ListTile(
          leading: Icon(Icons.notifications_active_outlined),
          title: Text(model.text ,style: AppTextStyle.mediumBlack,),
          subtitle:  Text(model.createdAt , style: AppTextStyle.smallBlackThin,),
        ),
      ),
    );
  }
}
