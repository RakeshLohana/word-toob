import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/app_constants/route_strings.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';
import 'package:word_toob/views/widgets/custom_bottom_sheet.dart';
import 'package:word_toob/views/widgets/custom_bottom_sheet_video.dart';
import 'package:word_toob/views/widgets/video_thumbnail_fleet.dart';
import 'package:word_toob/views/widgets/video_widget.dart';

class EditPopOver extends StatefulWidget {
  final String title;
  final String picture;
  const EditPopOver({super.key, required this.title, required this.picture});

  @override
  State<EditPopOver> createState() => _EditPopOverState();
}


class _EditPopOverState extends State<EditPopOver> {

  TextEditingController _controller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

}
  @override
  Widget build(BuildContext context) {
    double fontSize=context.height*0.02;

    return Consumer<MainDashboardController>(
      builder: (context, mainDashboardController, child) =>
       Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                GrayContainerWidget(blueButton:mainDashboardController.isEditPressed?"Done": "Edit",title: widget.title,
                  blueButtonOnTap: (){
                  mainDashboardController.isEditPressedFun();
                  setState(() {
                    _controller.text=widget.title;

                  });

                  },),
            
                IntrinsicHeight(
            
                  child: Row(
                    children: [
                      Gap(10),
            
                      Column(
                        children: [

                          Gap(10),

                       mainDashboardController.isEditPressed?           SizedBox(
                         width: context.width*0.1,
                         child: TextFormField(
                           onTapOutside: (e){FocusManager.instance.primaryFocus?.unfocus();},



                           // prefixIcon: Icon(Icons.search,size:iconSize+2,),

                           style: TextStyle(fontSize: fontSize,color: AppColor.appPrimaryColor),

                           controller: _controller,
                           decoration: InputDecoration(
                           ),

                         ),
                       )
                        :   Text(widget.title,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.appPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize
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
                                fontSize: fontSize

                            ),
                          ),
                          Gap(10),
            
                          Text("Hide Word",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.appPrimaryColor,
                              fontWeight: FontWeight.bold,
                                fontSize: fontSize

                            ),
                          ),
            
            
            
                        ],
                      ),
                      VerticalDivider(color: AppColor.shadowColor2,thickness: 2,),
            
                      Expanded(
                        child: Column(

                          children: [
                            Gap(10),

                            Text("${mainDashboardController.videos.length} Videos",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColor.appPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize
                              ),
                            ),
                            Gap(10),
                            GestureDetector(
                              onTap: () {
                                mainDashboardController.toggleBottomSheetVideo();
                              },
                              child: Text("Add Videos",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                            Divider(color: AppColor.shadowColor2,thickness: 2,),
                            Column(
                              children: List.generate(mainDashboardController.videos.length, (index) {
                                final video=mainDashboardController.videos[index];
                                return VideoUploadWidget(
                                  isEditPressed: mainDashboardController.isEditPressed,
                                  onTapRemove: (){
                                  mainDashboardController. removeVideosFromList(index);
                                  }, video: video,onTap: () {
                                  Navigator.pushNamed(context, RouteStrings.videoPlayer, arguments: video);
                        
                                },);
                              }
                            )
                            )
                                    
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
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
