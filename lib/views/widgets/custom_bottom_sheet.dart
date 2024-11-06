import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';

import '../../app_providers/content_provider.dart';

class CustomBottomSheet extends StatelessWidget {
  final int id;
  final int index;
  final int gridIndex;
  CustomBottomSheet({
    required this.id, required this.index, required this.gridIndex});

  @override
  Widget build(BuildContext context) {
    printLog("Index at grid :"+index.toString());
    printLog("List index  :"+gridIndex.toString());
    printLog("id of   :"+gridIndex.toString());
    return Consumer2<ContentProvider,MainDashboardController>(
      builder: (context, contentProvider, controller, child) =>
       Padding(
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
                    if(image!=null){
                      controller.getImagePath(image!.path);


                      await  contentProvider.updateListDataItem(id: controller.gridSizedModel.id??-1, itemIndex: index,imagePath: image.path);

                      controller.setGridSize(contentProvider.allGridSizedModel[gridIndex].gridSizeX??1, contentProvider.allGridSizedModel[gridIndex].gridSizeY??2);
                      controller.setGridSizedModel(contentProvider.allGridSizedModel[gridIndex],gridIndex);
                      // printLog("Picked image path:"+image.path);
                      // printLog("Index at grid :"+index.toString());
                      // printLog("GridSizedModel Saved: "+contentProvider.allGridSizedModel[gridIndex].toJson().toString());

                      controller.toggleBottomSheetOff();
                    }

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
                  if(image!=null){
                    controller.getImagePath(image.path);
                    controller.getImagePath(image.path);
                    await  contentProvider.updateListDataItem(id: id, itemIndex: index,imagePath: image.path);

                    controller.setGridSize(contentProvider.allGridSizedModel[gridIndex].gridSizeX??1, contentProvider.allGridSizedModel[gridIndex].gridSizeY??2);
                    controller.setGridSizedModel(contentProvider.allGridSizedModel[gridIndex],gridIndex);

                    controller.toggleBottomSheetOff();

                  }


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
      ),
    );
  }
}
