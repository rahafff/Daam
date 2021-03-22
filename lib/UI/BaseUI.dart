

import 'package:first_card_project/Bloc/BaseBloc.dart';
import 'package:first_card_project/Resources/AppMsg.dart';
import 'package:first_card_project/Widget/AppDialogs.dart';
import 'package:flutter/material.dart';

abstract class BaseUI<Bloc extends BaseBloc> extends StatefulWidget {
  final Bloc bloc ;

  BaseUI({this.bloc});

}

abstract class BaseUIState<basePage extends BaseUI> extends State<basePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.buildAppBar(),
      body: Stack(
        children: <Widget>[
          //helper.background(context),
          StreamBuilder<int>(
            stream: widget.bloc.uiErrorsStream,
            builder: (context, snapshot) {
              if(snapshot.hasData)
                {
                 return Container();
                }
              return this.buildUI(context);

            }
          ),
        ],
      )
    );
  }

  Widget buildUI(BuildContext context);
  AppBar buildAppBar();

  @override
  void initState() {
    widget.bloc.errorsStream.listen((data){
      showErrorDialog(context,data);
      //widget.bloc.uiErrorConteroller.sink.add(error.code);
    },onError: (error){});
    this.init();
    super.initState();
  }
  void init();
  void disposeControllers(){}

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }


  Widget noInternetConnection(){
    return Container();
  }
  void handleNotAuthUser(){

  }
}
