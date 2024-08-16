import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';
import 'package:word_toob/views/widgets/custom_bottom_sheet.dart';
import 'package:word_toob/views/widgets/custom_bottom_sheet_video.dart';
import 'package:word_toob/views/widgets/video_widget.dart';

class EditPopOver extends StatefulWidget {
  final String title;
  final String picture;
  const EditPopOver({super.key, required this.title, required this.picture});

  @override
  State<EditPopOver> createState() => _EditPopOverState();
}


class _EditPopOverState extends State<EditPopOver> {



  @override
  Widget build(BuildContext context) {
    return Consumer<MainDashboardController>(
      builder: (context, mainDashboardController, child) =>
       Stack(
        children: [
          Column(
            children: [
              GrayContainerWidget(blueButton: "Edit",title: widget.title,
                blueButtonOnTap: (){},),

              IntrinsicHeight(

                child: Row(
                  children: [
                    Gap(10),

                    Column(
                      children: [

                        Text(widget.title,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.appPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            mainDashboardController.toggleBottomSheet();
                          },
                          child: mainDashboardController.imagePath=="" ?CachedNetworkImage(
                            height: 60,
                            imageUrl: widget.picture,):Image.file(File(mainDashboardController.imagePath),height: 80,width: 80,),

                        ),
                        Gap(10),

                        Text("Edit Picture",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.appPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(10),

                        Text("Hide Word",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.appPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),



                      ],
                    ),
                    VerticalDivider(color: AppColor.shadowColor2,thickness: 2,),

                    Column(
                      children: [
                        Text("2 Videos",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.appPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            mainDashboardController.toggleBottomSheetVideo();
                          },
                          child: Text("Add Videos",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(color: AppColor.shadowColor2,thickness: 2,),
                        Column(
                          children: List.generate(mainDashboardController.videos.length, (index) =>VideoThumbnail(mainDashboardController.videos[index])
                        )
                        )

                      ],
                    )
                  ],
                ),
              )
            ],
          ),

          if (mainDashboardController.showBottomSheetVideo)
            GestureDetector(
              onTap: () {
                mainDashboardController.toggleBottomSheetOffVideo();

              },
              child: Container(
                color: mainDashboardController.showBottomSheetVideo?AppColor.black.withOpacity(0.5):Colors.transparent,

              ),
            ),

          if (mainDashboardController.showBottomSheetVideo)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomSheetVideo(controller: mainDashboardController,),
            ),


          if (mainDashboardController.showBottomSheet)

            GestureDetector(
              onTap: () {
                mainDashboardController.toggleBottomSheetOff();

              },
              child: Container(
              color: mainDashboardController.showBottomSheet?AppColor.black.withOpacity(0.5):Colors.transparent,

                        ),
            ),

          if (mainDashboardController.showBottomSheet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomSheet(controller: mainDashboardController,),
            ),
        ],
      ),
    );
  }
}
