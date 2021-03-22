import 'package:first_card_project/Bloc/CardsBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/CardsModel.dart';
import 'package:first_card_project/UI/Cards/CardDetails.dart';
import 'package:flutter/material.dart';

class CardCard extends StatelessWidget {
  final CardItem data;
  final CardsBloc bloc;

  const CardCard({Key key, this.data, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CardDetails(card: data,bloc: bloc,)
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: AppColors.green , ),
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white /*.withOpacity(0.01)*/
              ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(200)),
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Hero(
                        tag: data.id.toString()+"img",
                          child: Image.network(
                        AppConstant.IMAGE_URL + data.photo,
                        width: 75,
                        height: 75,
                        fit: BoxFit.fill,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: AppTextStyle.mediumBlack,
                      ),
//                      SizedBox(height: 8,),
//                      Text(data.description , style: AppTextStyle.smallBlackThin,),
//                      SizedBox(height: 8,),
//                      Text(data.network.name , style: AppTextStyle.smallBlackThin,),
                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context).trans("expiry") +
                                ' ' +
                                data.expireAt +
                                ' ' +
                                AppLocalizations.of(context).trans('day'),
                            style: AppTextStyle.smallBlackThin,
                          ),
                          Text(
                            AppLocalizations.of(context).trans("price") +
                                ' ' +
                                data.price +
                                ' ' +
                                AppLocalizations.of(context).trans('sp'),
                            style: AppTextStyle.smallBlackBold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
