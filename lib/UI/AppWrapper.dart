import 'package:first_card_project/UI/Home.dart';
import 'package:flutter/material.dart';
class AppWrapper extends StatefulWidget {
  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {

  List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    pages = [Home()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[0],
    );
  }
}
