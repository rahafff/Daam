import 'package:first_card_project/Bloc/GeneralBloc.dart';
import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/GeneralRespones.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode subjectFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(context, AppLocalizations.of(context).trans("contactUs")),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              helper.getTextField(nameController, false, nameFocus, emailFocus, AppLocalizations.of(context).trans("name")),
              helper.getTextField(emailController, false, emailFocus, phoneFocus, AppLocalizations.of(context).trans("email")),
              helper.getTextField(phoneController, false, phoneFocus, subjectFocus, AppLocalizations.of(context).trans("phone")),
              helper.getTextField(subjectController, false, subjectFocus, messageFocus, AppLocalizations.of(context).trans("subject")),
              helper.getTextField(messageController, false, messageFocus, null, AppLocalizations.of(context).trans("message"),maxLines: 5),
              CustomAppButton(
                elevation: 0,
                onTap: (){
                  setState(() {
                    isLoading = true;
                  });
                  genBloc.sendMsg(
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    message: messageController.text,
                    subject: subjectController.text,
                    onData: (GeneralModel data){
                      if(data.message == "Success")
                        {
                          setState(() {
                            isLoading = false;
                          });
                          showErrorDialog(context, "تم استلام رسالتك بنجاح",isError: false);
                        }
                      else{

                        setState(() {
                          isLoading = false;
                        });
                        showErrorDialog(context, data.message);
                      }
                    }
                  );
                },
                borderRadius: 20,
                color: AppColors.cyan,
                child: Text(AppLocalizations.of(context).trans("submit") , style: AppTextStyle.normalWhiteBold,),
                padding: EdgeInsets.symmetric(horizontal: 25 , vertical: 8),
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    subjectFocus.dispose();
    messageFocus.dispose();
    super.dispose();
  }
}
