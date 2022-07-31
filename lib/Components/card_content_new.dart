import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/HomeOrderAccount/Home/UI/Stores/stores.dart';
import 'package:user/HomeOrderAccount/Home/UI/appcategory/appcategory.dart';
import 'package:user/HomeOrderAccount/Home/UI/home2.dart';

import 'package:user/Themes/colors.dart';
import 'package:user/bean/nearstorebean.dart';
import 'package:user/pharmacy/pharmadetailpage.dart';
import 'package:user/pharmacy/pharmastore.dart';
import 'package:user/restaturantui/pages/restaurant.dart';
import 'package:user/restaturantui/ui/resturanthome.dart';


class CardContentNew extends StatelessWidget {
  final String text;
  final String image;
  final List<dynamic> list;
  final String ui_type;
  final int id;
  final BuildContext context;

  CardContentNew({this.text, this.image,this.list,this.ui_type,this.id,this.context});

  /// Outlines a text using shadows.
  static List<Shadow> outlinedText({double strokeWidth = 2, Color strokeColor = Colors.black, int precision = 5}) {
    Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for(int y = 1; y < strokeWidth + precision; y++) {
        double offsetX = x.toDouble();
        double offsetY = y.toDouble();
        result.add(Shadow(offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY), color: strokeColor));
        result.add(Shadow(offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY), color: strokeColor));
        result.add(Shadow(offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY), color: strokeColor));
        result.add(Shadow(offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY), color: strokeColor));
      }
    }
    return result.toList();
  }

  @override
  Widget build(BuildContext context) {
    print("** " + list.toString());
    var tagObjsJson = list;
    List<NearStores> tagObjs = tagObjsJson
        .map((tagJson) => NearStores.fromJson(tagJson))
        .toList();
    print("***** " + tagObjs[0].toString());
    void hitNavigator(context, category_name, ui_type,
        vendor_category_id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (ui_type == "grocery" || ui_type == "Grocery" || ui_type == "1") {
        prefs.setString("vendor_cat_id", '${vendor_category_id}');
        prefs.setString("ui_type", '${ui_type}');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StoresPage(category_name, vendor_category_id)));
      } else if (ui_type == "resturant" ||
          ui_type == "Resturant" ||
          ui_type == "2") {
        prefs.setString("vendor_cat_id", '${vendor_category_id}');
        prefs.setString("ui_type", '${ui_type}');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Restaurant("Urbanby Resturant")));
      } else if (ui_type == "pharmacy" ||
          ui_type == "Pharmacy" ||
          ui_type == "3") {
        prefs.setString("vendor_cat_id", '${vendor_category_id}');
        prefs.setString("ui_type", '${ui_type}');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StoresPharmaPage('${category_name}', vendor_category_id)));
      } else if (ui_type == "parcal" || ui_type == "Parcal" || ui_type == "4") {
        prefs.setString("vendor_cat_id", '${vendor_category_id}');
        prefs.setString("ui_type", '${ui_type}');
        hitNavigator1(
            context,
            tagObjs[0].vendor_name,
            tagObjs[0].vendor_id,
            tagObjs[0].distance);


        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ParcalStoresPage('${vendor_category_id}')));

      }
    }

    if (list.isEmpty) {
      return
            Container(
                child: Container(
                  child: Text("No DATA",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),

            )
            ));
    }
    else{
      return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Container(
                  child: Text(text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),
                  ),
                )
            ),
            ConstrainedBox(
                constraints: new BoxConstraints(
                  minWidth: 120,
                  maxHeight: 100,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Card(
                            margin: EdgeInsets.all(8),
                            child:
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    height: 150,
                                    child: new GestureDetector(
                                        onTap: () {
                                          print("Container clicked 2");
                                          if (ui_type == "1") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppCategory(
                                                            tagObjs[index]
                                                                .vendor_name,
                                                            tagObjs[index]
                                                                .vendor_id,
                                                            tagObjs[index]
                                                                .distance)))
                                                .then((value) {
                                              //getCartCount();
                                            });
                                          }
                                          else if (ui_type == "2") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Restaurant_Sub(
                                                            tagObjs[index],
                                                            "Rs ")))
                                                .then((value) {});
                                          }

                                          else if (ui_type == "3") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PharmaItemPage(
                                                            tagObjs[index]
                                                                .vendor_name,
                                                            tagObjs[index]
                                                                .vendor_id,
                                                            tagObjs[index]
                                                                .delivery_range,
                                                            tagObjs[index]
                                                                .distance)))
                                                .then((value) {});
                                          }
                                          else if (ui_type == "4") {
                                            hitNavigator(
                                                context,
                                                text,
                                                ui_type,
                                                id);
                                          }
                                        },
                                        child: Container(
                                            width: 50,
                                            height: 50,
                                            child:
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: Image.network(
                                                        image,
                                                        height: 50,
                                                        width: 50,
                                                        alignment: Alignment
                                                            .topRight,
                                                      ),

                                                    ),
                                                  ),
                                                  Container(
                                                      height: 100,
                                                      width: 100,
                                                      child:
                                                      Text(
                                                        tagObjs[index]
                                                            .vendor_name,
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            color: black_color,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 14),
                                                      )
                                                  ),
                                                ]
                                            )
                                        )
                                    ),

                                  )
                                ]
                            )
                        )
                )
            )

          ]
      );
    }
  }
}