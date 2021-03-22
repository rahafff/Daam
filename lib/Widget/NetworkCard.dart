import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/NetworksModel.dart';
import 'package:first_card_project/UI/Coupons/CouponsPage.dart';
import 'package:first_card_project/UI/ServiceProviders/ServiceProvidersPage.dart';
import 'package:flutter/material.dart';
class NetworkCard extends StatelessWidget {

  final Datum data;
  final String type;
  const NetworkCard({Key key, this.data, this.type = "markets"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(type == "markets")
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ServiceProvidersPage(networkId: data.id.toString(),networkName: data.name,)
        ));
        else
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CouponsPage(networkId: data.id.toString(),networkName: data.name,)
          ));
      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                // color: AppColors.pink.withOpacity(0.5)
                  image: DecorationImage(
                      image: NetworkImage(AppConstant.IMAGE_URL + data.photo,),
                          //"https://picsum.photos/500?salt=${math.Random().nextInt(10)}"),
                      alignment: Alignment.center,
                      fit: BoxFit.fill)),
              alignment: Alignment.center,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "${type == "markets"?"":AppLocalizations.of(context).trans(type)+" "}"+data.name,
                    style: AppTextStyle.mediumBlackBold,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
