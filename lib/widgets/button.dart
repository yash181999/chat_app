import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final dynamic text, onClickMethod, color,height, width,textColor;
  CustomButton({this.text, this.onClickMethod,this.color,this.height,this.width,this.textColor});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width*0.80,
      height: height ??  MediaQuery.of(context).size.height*0.06,
      child: MaterialButton(
        onPressed: (){
          onClickMethod();
        },
        color: color,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontFamily: 'sf_pro_medium',
          ),
        ),
        shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
