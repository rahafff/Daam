//import 'package:flutter/material.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
//class AnimationScaleWidget extends StatelessWidget {
//  int position;
//  double horizontalOffset, verticalOffset;
//  Widget child;
//
//  AnimationScaleWidget(
//      {@required this.position,@required this.horizontalOffset,@required this.verticalOffset,@required this.child});
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimationConfiguration.staggeredList(
//      position: position,
//      duration: const Duration(milliseconds: 800),
//      child: SlideAnimation(
//        horizontalOffset: horizontalOffset,
//        verticalOffset: verticalOffset,
//        child: FadeInAnimation(
//          child: child,
//        ),
//      ),
//    );
//  }
//}