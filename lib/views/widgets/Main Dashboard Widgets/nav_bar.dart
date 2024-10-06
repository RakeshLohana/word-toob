import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:word_toob/app_providers/content_provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/views/screens/main_dashboard.dart';

import 'package:word_toob/views/theme/app_color.dart';











class NormalNavBar extends StatelessWidget {
  final MainDashboardController value;
  final ContentProvider contentProvider;
  final MenuController menuController;

  NormalNavBar({
    super.key,
    required this.addMap,
    required this.sizeWidth, required this.value, required this.contentProvider, required this.menuController,
  });

  final List<Map<String, dynamic>> addMap;
  final double sizeWidth;
  final MenuController menuController2=MenuController();


  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> gameMap=[
      {
        "name":"Free Play",
        "onTap":(){

          menuController.close();
          value.setFreePlayOn(true);



        }
      },
      {
        "name":"Find The Word",
        "onTap":(){
          menuController.close();
          value.setFindTheWord(true);
          value.setRandomIndex();
        }
      }

    ];

    double fontSize=context.height*0.025;
    double iconSize=context.height*0.04;
    double gap=15;

    return Container(
      height: context.height*0.12,

      color: AppColor.white,
      padding: EdgeInsets.symmetric(horizontal:10,vertical:0),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [



          LeftRow(addMap: addMap,
              menuController2: menuController2,
              iconSize: iconSize, sizeWidth: sizeWidth, contentProvider: contentProvider, value: value, fontSize: fontSize),


          CenterTitle(value: value, fontSize: fontSize),


          if(!value.findTheWord)
            RightRow(menuController: menuController, gameMap: gameMap, fontSize: fontSize, sizeWidth: sizeWidth, value: value, gap: gap)
          else
            FindTheWordRow(fontSize: fontSize, sizeWidth: sizeWidth, mainDashboardController: value,menuController: menuController,)
        ],
      ),

    );
  }
}

class FindTheWordRow extends StatelessWidget {
 final MainDashboardController mainDashboardController;
  const FindTheWordRow({
    super.key,
    required this.fontSize,
    required this.sizeWidth,
    required this.mainDashboardController, required this.menuController
  });

  final double fontSize;
  final MenuController menuController;
  final double sizeWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            mainDashboardController.setCurrentIndex();
            mainDashboardController.clearFindTheWrongList();
          },
          child: Text("Repeat",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize
          )),
        ),
        SizedBox(width: sizeWidth,),
        GestureDetector(
          onTap: () {
            mainDashboardController.setRandomIndex();
            mainDashboardController.clearFindTheWrongList();
          },
          child: Text("Skip",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize
          )),
        ),
        SizedBox(width: sizeWidth,),
        SettingButton(fontSize: fontSize, gap: 5, value: mainDashboardController,gameMenuController: menuController ),
        // GestureDetector(
        //   onTap: () {
        //
        //   },
        //   child: Text("Settings",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        //       fontWeight: FontWeight.bold,
        //       fontSize: fontSize
        //   )),
        // ),
        SizedBox(width: sizeWidth,),
        GestureDetector(
          onTap: () {
            mainDashboardController.setFindTheWord(false);
            mainDashboardController.clearFindTheWrongList();
            mainDashboardController.setFindWordImage(false);


          },
          child: Text("Done",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.appPrimaryColor,
              fontSize: fontSize
          )),
        ),
      ],
    );
  }
}
