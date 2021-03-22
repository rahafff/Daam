import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Models/serviceProvidersModel.dart';
import 'package:first_card_project/UI/ServiceProviders/ServiceProviderDetails.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ServiceProviderCard extends StatelessWidget {
  final ServiceProvider data;
  final ServiceProvidersBloc bloc;
  const ServiceProviderCard({Key key, this.data, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          onTap: (){

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ServiceProviderDetails(providerId: data.id.toString(),bloc: bloc,)
            ));
          },
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 16 ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5)
            ),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: AppConstant.IMAGE_URL + data.photo,
                          fit: BoxFit.fill,

                          height: 100,
                        ),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.businessName , style: AppTextStyle.mediumBlackBold,),
                          SizedBox(height: 8,),
                          Directionality(
                            textDirection:TextDirection.ltr,
                            child: SmoothStarRating(
                              starCount: 5,
                              isReadOnly: true,
                              rating: double.parse(data.rate??"0.0"),
                              color: AppColors.orange,
                              borderColor: AppColors.orange,
                            ),
                          ),
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
