import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';

import '../../app_providers/content_provider.dart';

class CustomBottomSheet extends StatelessWidget {
  final int id;
  final int index;
  final int gridIndex;
  final MainDashboardController controller;
 final ContentProvider contentProvider;
  CustomBottomSheet({required this.controller, required this.id, required this.index, required this.contentProvider, required this.gridIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                  var image=  await AppUtility.imageFromCamera();
                    controller.getImagePath(image!.path);
                  contentProvider.updateListDataItem(id: id, itemIndex: index,imagePath: image.path);

                  controller.setGridSize(contentProvider.allGridSizedModel[gridIndex].gridSizeX??1, contentProvider.allGridSizedModel[gridIndex].gridSizeY??2);
                  controller.setGridSizedModel(contentProvider.allGridSizedModel[gridIndex],gridIndex);
                  controller.toggleBottomSheetOff();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),

                    child: Text('Take Photo',style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                        color: AppColor.blue

                    ),),
                  ),
                ),
                GestureDetector(
                  onTap: () async{

                var image=  await AppUtility.imageFromGallery();
                controller.getImagePath(image!.path);
                controller.getImagePath(image!.path);
                contentProvider.updateListDataItem(id: id, itemIndex: index,imagePath: image.path);

                controller.setGridSize(contentProvider.allGridSizedModel[gridIndex].gridSizeX??1, contentProvider.allGridSizedModel[gridIndex].gridSizeY??2);
                controller.setGridSizedModel(contentProvider.allGridSizedModel[gridIndex],gridIndex);

                controller.toggleBottomSheetOff();


                  },
                  child: Container(

                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),

                    child: Text('Choose Existing',style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue
                    ),),
                  ),
                ),
                Gap(10),
              ],
            ),
          ),
          Gap(3),
          GestureDetector(
            onTap: () {
              controller.toggleBottomSheetOff();

            },
            child: Container(

              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child:       Center(
                child: Text(' Cancel',style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.blue

                ),),
              ),
            ),
          )

        ],
      ),
    );
  }
}
