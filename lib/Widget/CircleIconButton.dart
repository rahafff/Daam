import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final VoidCallback function;
  final String icon;
  final String category;
  final Color color;
  bool clicked;

  CircleIconButton({
    @required this.function,
    @required this.icon,
    @required this.category,
    @required this.color,
    this.clicked = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: function,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                width: MediaQuery.of(context).size.width/6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(icon , width: 30,height: 30,),
//                  Text(
//                    category,
//                    style: TextStyle(
//                      color: color,
//                      fontSize: AppFontsSize.getScaledFontSize(
//                          AppFontsSize.xx_small_font_size),
//                    ),
//                  ),
                  ],
                ),
              ),
            ),
          ),

        ),
      ],
    );
  }
}
