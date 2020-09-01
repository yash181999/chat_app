import 'package:flutter/material.dart';

class CardTopHeading extends StatelessWidget {

  final String leftText, rightText;
  CardTopHeading({@required this.leftText, @required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText,
          style: TextStyle(
              fontFamily: 'sf_pro_bold',
              fontSize: 24
          ),
        ),

        Text(rightText,
          style: TextStyle(
              color: Colors.lightBlue,
              fontFamily: 'sf_pro_bold',
              fontSize: 16
          ),
        ),
      ],
    );
  }
}
