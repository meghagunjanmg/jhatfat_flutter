import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/Themes/colors.dart';

class CardContent extends StatelessWidget {
  final String text;
  final String image;

  CardContent({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return
      Container(
          height: 80,
          width: 80,
      child: Column(
      mainAxisSize:MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
           Container(
            child: Image.network(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            ),
          ),
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: black_color, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ],
      )
    );

  }
}
