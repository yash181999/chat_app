import 'package:flutter/material.dart';

class CountWidget extends StatelessWidget {

  final String count;
  final String title;
  CountWidget({@required this.title, @required this.count});




  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count,
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'sf_pro_bold'
            ),
          ),

          Text(
           title,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'sf_pro_regular'
            ),
          )
        ],
      ),
    );
  }
}
