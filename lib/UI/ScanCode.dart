import 'package:date_format/date_format.dart';
import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/DataStore.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/User.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanCode extends StatefulWidget {
  final String providerID;

  const ScanCode({Key key, this.providerID}) : super(key: key);
  @override
  _ScanCodeState createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  bool hasPermission = false;

  @override
  void initState() {
    // _handleCameraAndMic().then((value) {
    //   hasPermission = value;
    //   if (value) {
    //     if (mounted) {
    //       setState(() {});
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(
          context, AppLocalizations.of(context).trans("scanCode")),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Center(
            child: Text(
              AppLocalizations.of(context)
                  .trans("scan"),
              style: AppTextStyle.mediumWhiteBold,
            ),
          ),
          SizedBox(height: 50,),
          QrImage(
            data: "${widget.providerID}",
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: AppColors.white,
          ),
          SizedBox(height: 50,),
          Text( AppLocalizations.of(context)
              .trans("or"),style: AppTextStyle.mediumWhite,),
          SizedBox(height: 10,),
          Text( AppLocalizations.of(context)
              .trans("enterCode"),style: AppTextStyle.mediumWhite,),
          Text(widget.providerID ,style: AppTextStyle.largeWhiteBold,)
          // GestureDetector(
          //   onTap: () async {
          //     FocusScope.of(context).unfocus();
          //     if (Utils.isTextEmpty(_value)) {
          //       showErrorDialog(
          //           context,
          //           AppLocalizations.of(context)
          //               .trans("pleaseEnterValue"));
          //       return;
          //     }
          //     QrImage(
          //       data: "${1}",
          //       version: QrVersions.auto,
          //       size: 200.0,
          //       backgroundColor: AppColors.white,
          //     );
          //     // BarcodeScanner.scan().then((value) {
          //     //   if (value.rawContent == "" ||
          //     //       value.rawContent == null) return;
          //     //   payload = value.rawContent;
          //     //   setState(() {
          //     //     if (payload != null && payload.isNotEmpty) {
          //     //       if (isCard)
          //     //         genBloc.scanCode(payload, "${_value.text}",
          //     //                 () {
          //     //               setState(() {
          //     //                 success = true;
          //     //               });
          //     //             }, (msg) {
          //     //               setState(() {
          //     //                 payload = null;
          //     //               });
          //     //               if (msg != null)
          //     //                 showErrorDialog(context, msg);
          //     //             });
          //     //       else
          //     //         genBloc.scanCouponCode(
          //     //             payload, "${_value.text}", () {
          //     //           setState(() {
          //     //             success = true;
          //     //           });
          //     //         }, (msg) {
          //     //           setState(() {
          //     //             payload = null;
          //     //           });
          //     //           if (msg != null)
          //     //             showErrorDialog(context, msg);
          //     //         });
          //     //     }
          //     //   });
          //     // });
          //   },
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.qr_code_scanner,
          //         color: AppColors.white,
          //         size: MediaQuery.of(context).size.width * 0.7,
          //       ),
          //       SizedBox(
          //         height: 12,
          //       ),
          //       Container(
          //         child: Text(
          //           AppLocalizations.of(context)
          //               .trans("clickToScan"),
          //           style: AppTextStyle.mediumWhiteBold,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      )
    );
  }

  // Future<bool> _handleCameraAndMic() async {
  //   var res = await [Permission.camera].request();
  //   return (res[Permission.camera] == PermissionStatus.granted) &&
  //       (res[Permission.microphone] == PermissionStatus.granted) &&
  //       (res[Permission.storage] == PermissionStatus.granted);
  // }
}
