

import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Models/SalesCenters.dart';
import 'package:flutter/material.dart';

import 'SalesCenterDetails.dart';
class SalesCenterCard extends StatelessWidget {
  final SalesCenter data;

  const SalesCenterCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          onTap: (){
           Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => SalesCenterDetails(data: data,)
           ));
          },
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 16 ),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                children: [
//                  Expanded(
//                      flex: 1,
//                      child: Container(
//                        /*child: CachedNetworkImage(
//                          imageUrl: AppConstant.IMAGE_URL + data.,
//                          fit: BoxFit.cover,
//
//                          height: MediaQuery.of(context).size.height * 0.1,
//                        ),*/
//                      )),
//                  SizedBox(
//                    width: 8,
//                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.name , style: AppTextStyle.mediumBlackBold,)
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
