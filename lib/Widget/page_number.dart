import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Models/pageModel.dart';
import 'package:flutter/material.dart';

class PageNumber extends StatelessWidget {

  final PageModel model;
  final Function changePage;

  PageNumber({this.model, this.changePage, });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        changePage();
      },
      child: Card(
        color: model.isSelected ? AppColors.deepYellow:AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.number),
        ),
      ),
    );
  }
}
