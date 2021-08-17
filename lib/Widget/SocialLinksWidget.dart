import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Models/SocialLinksModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLinksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SocialLinksModel>(
        stream: genBloc.socialStream,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              children: [
                socialItem(name: 'facebook' , links: snapshot.data.data.facebook),
                socialItem(name: 'twitter' , links: snapshot.data.data.twitter),
                socialItem(name: 'instagram' , links: snapshot.data.data.instagram),
                socialItem(name: 'linkedin' , links: snapshot.data.data.linkedIn),
                socialItem(name: 'youtube' , links: snapshot.data.data.youtube),
                socialItem(name: 'apple' , links: snapshot.data.data.phone),
                socialItem(name: 'mail' , links: snapshot.data.data.email),
              ],
            );
          return Container();
        });
  }


}
Widget socialItem({String name, String links}) {
  return InkWell(
    onTap: () {
      Utils.lunchURL(name == 'mail'?"mailto:$links":name == 'apple'?"tel:$links":links);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: name == 'facebook' || name == 'mail'?AppColors.white:name == 'apple'?AppColors.green:Colors.transparent,
            borderRadius: BorderRadius.circular(5)
        ),
        child: SvgPicture.asset(
          "assets/images/$name.svg",
          height: 20,
          width: 20,
        ),
      ),
    ),
  );
}