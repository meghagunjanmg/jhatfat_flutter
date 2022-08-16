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
          height: 200,
          width: 200,
      child: Column(
      mainAxisSize:MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

           Container(
             height: 50,
             width: 50,
            child: Image.network(
              image,
              height: 20,
              width: 20,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),

            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0,top: 5,bottom: 5),
              child: Text(
                text,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  wordSpacing: 0,
                  height: 1),
              ),
            ),
          ],
      )
    );

  }
}
