import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppConstant.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Models/SalesCenters.dart';
import 'package:first_card_project/Widget/GoogleMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class SalesCenterDetails extends StatefulWidget {
  final SalesCenter data;

  const SalesCenterDetails({Key key, this.data}) : super(key: key);


  @override
  _SalesCenterDetailsState createState() => _SalesCenterDetailsState();
}

class _SalesCenterDetailsState extends State<SalesCenterDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.name,
          style: AppTextStyle.normalWhiteBold.copyWith(fontWeight: FontWeight.bold/*,color: AppColors.orange*/ ),
        ),
        backgroundColor: AppColors.lightBlack,
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    child: SvgPicture.asset(
                      "assets/images/apple.svg",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                Text(
                  widget.data.phoneNumber,
                  style: AppTextStyle.mediumWhiteBold,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    child: SvgPicture.asset(
                      "assets/images/mail.svg",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                Text(
                  widget.data.email??"",
                  style: AppTextStyle.mediumWhiteBold,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.location_city,
                        size: 20,
                      )),
                ),
                Flexible(
                  child: Text(
                    widget.data.location,
                    style: AppTextStyle.mediumWhiteBold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  widget.data.longitude == null ?Container():Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: MapWidget(LatLng(double.parse(widget.data.latitude??"0.0"), double.parse(widget.data.longitude??"0.0"))),
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
    );
  }

}
