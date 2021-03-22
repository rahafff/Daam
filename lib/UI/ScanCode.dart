import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanCode extends StatefulWidget {
  @override
  _ScanCodeState createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  TextEditingController _value = TextEditingController();
  TextEditingController _serial = TextEditingController();

  String payload;
  bool hasPermission = false, success = false;
  bool isCard = true;

  @override
  void initState() {
    _handleCameraAndMic().then((value) {
      hasPermission = value;
      if (value) {
        if (mounted) {
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(
          context, AppLocalizations.of(context).trans("scanCode")),
      body: success
          ? Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).trans("scannedSuccessfully"),
                    style: AppTextStyle.largeWhiteBold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomAppButton(
                    color: AppColors.cyan,
                    child: Text(
                      AppLocalizations.of(context).trans("back"),
                      style: AppTextStyle.mediumWhiteBold,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderRadius: 25,
                    onTap: () {
                      setState(() {
                        payload = null;
                        success = false;
                        _serial.text = "";
                        _value.text = "";
                      });
                    },
                  )
                ],
              ),
            )
          : payload == null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      helper.getTextField(
                          _value,
                          false,
                          null,
                          null,
                          AppLocalizations.of(context)
                              .trans("pleaseEnterValue"),
                          inputType: TextInputType.number),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        AppLocalizations.of(context).trans("chooseScanType"),
                        style: AppTextStyle.normalWhiteBold,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCard = true;
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context).trans("card"),
                                style: isCard
                                    ? AppTextStyle.mediumWhiteBold
                                    : AppTextStyle.mediumWhiteBold
                                        .copyWith(color: AppColors.gray),
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCard = false;
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context).trans("coupon"),
                                style: !isCard
                                    ? AppTextStyle.mediumWhiteBold
                                    : AppTextStyle.mediumWhiteBold.copyWith(
                                        color:
                                            AppColors.white.withOpacity(0.3)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (Utils.isTextEmpty(_value)) {
                            showErrorDialog(
                                context,
                                AppLocalizations.of(context)
                                    .trans("pleaseEnterValue"));
                            return;
                          }
                          BarcodeScanner.scan().then((value) {
                            if (value.rawContent == "" ||
                                value.rawContent == null) return;
                            payload = value.rawContent;
                            setState(() {
                              if (payload != null && payload.isNotEmpty) {
                                if (isCard)
                                  genBloc.scanCode(payload, "${_value.text}",
                                          () {
                                        setState(() {
                                          success = true;
                                        });
                                      }, (msg) {
                                        setState(() {
                                          payload = null;
                                        });
                                        if (msg != null)
                                          showErrorDialog(context, msg);
                                      });
                                else
                                  genBloc.scanCouponCode(
                                      payload, "${_value.text}", () {
                                    setState(() {
                                      success = true;
                                    });
                                  }, (msg) {
                                    setState(() {
                                      payload = null;
                                    });
                                    if (msg != null)
                                      showErrorDialog(context, msg);
                                  });
                              }
                            });
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              color: AppColors.white,
                              size: MediaQuery.of(context).size.width * 0.7,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              child: Text(
                                AppLocalizations.of(context)
                                    .trans("clickToScan"),
                                style: AppTextStyle.mediumWhiteBold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }

  Future<bool> _handleCameraAndMic() async {
    var res = await [Permission.camera].request();
    return (res[Permission.camera] == PermissionStatus.granted) &&
        (res[Permission.microphone] == PermissionStatus.granted) &&
        (res[Permission.storage] == PermissionStatus.granted);
  }
}
