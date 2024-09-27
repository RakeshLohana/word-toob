import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:word_toob/app_providers/content_provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';

class CustomBottomSheetVideo extends StatelessWidget {
  final MainDashboardController controller;
  final int id;
  final int index;
  final int gridIndex;
  CustomBottomSheetVideo({required this.controller, required this.id, required this.index, required this.gridIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentProvider>(
      builder: (context, contentProvider, child) =>
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
                    onTap: ()async {
                     var video= await  AppUtility.videoFromCamera();

                     controller.addVideoToList(video!.path,);
                     contentProvider.updateListDataItem(id: id, itemIndex: index,videosPath:controller.videos );
                     controller.setGridSizedModel(contentProvider.allGridSizedModel[controller.gridIndex],controller.gridIndex);
                     controller.toggleBottomSheetOffVideo();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),

                      child: Text('Take Video',style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.blue

                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{

                  var video= await  AppUtility.videoFromGallery();
                  print(video!.path);


                  controller.addVideoToList(video.path,);
                  contentProvider.updateListDataItem(id: id, itemIndex: index,videosPath:controller.videos );
                  controller.setGridSizedModel(contentProvider.allGridSizedModel[controller.gridIndex],controller.gridIndex);
                  controller.toggleBottomSheetOffVideo();






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
                controller.toggleBottomSheetOffVideo();

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
