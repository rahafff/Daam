import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Models/NewsModel.dart';
import 'package:first_card_project/UI/News/NewsDetails.dart';
import 'package:flutter/material.dart';
class NewsCard extends StatelessWidget {

  final News data;

  const NewsCard({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewsDetails(id: data.id.toString(),)
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height *0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Image.network(AppConstant.IMAGE_URL + data.photo , fit: BoxFit.fill,width: MediaQuery.of(context).size.width,)),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.title , style: AppTextStyle.mediumBlackBold,),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
