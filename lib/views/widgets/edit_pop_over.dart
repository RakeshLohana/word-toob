import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:word_toob/app_providers/content_provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/app_constants/general.dart';
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
  final int id;
  final int index;
  final int gridIndex;
  final bool  hide;
  const EditPopOver({super.key, required this.title, required this.picture, required this.id, required this.index, required this.gridIndex, required this.hide});

  @override
  State<EditPopOver> createState() => _EditPopOverState();
}


class _EditPopOverState extends State<EditPopOver> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

}



@override
void didUpdateWidget( EditPopOver oldWidget) {
  super.didUpdateWidget(oldWidget);

  if(widget.title!=oldWidget.title){
      printLog("This is title:  "+widget.title);
    }else{
      printLog("this is not updating---------->");
    }

}



  @override
  Widget build(BuildContext context) {
    double fontSize=context.height*0.02;
    printLog(widget.hide);

    return Consumer2<MainDashboardController,ContentProvider>(
      builder: (context, mainDashboardController, contentProvider,child) =>
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [




                    GrayNavBarOnEdit(widget: widget, mainDashboardController: mainDashboardController,contentProvider: contentProvider,),


                    IntrinsicHeight(

                      child: Row(
                        children: [
                          const Gap(10),

                          Column(
                            children: [

                             const Gap(10),

                              mainDashboardController.isEditPressed?SizedBox(
                                width: context.width*0.1,
                                child: TextFormField(

                                  onTapOutside: (e){FocusManager.instance.primaryFocus?.unfocus();},

                                  style: TextStyle(fontSize: fontSize,color: AppColor.appPrimaryColor),

                                  controller: mainDashboardController.editTitleTextEditingController,
                                  // decoration: InputDecoration(),

                                ),
                              )
                                  :   Text(widget.title,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColor.appPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize
                                ),
                              ),

                              const Gap(10),
                              if(widget.picture!="")
                                GestureDetector(
                                  onTap: () {
                                    mainDashboardController.toggleBottomSheet();
                                  },
                                  child: mainDashboardController.imagePath=="" ? 
                                  widget.picture.contains("asset")?
                                  Image.asset(widget.picture  ,height: 80,width: 80,) 
                                      : Image.file(File(widget.picture,),height: 80,width: 80,)
                                      : Image.file(File(mainDashboardController.imagePath),height: 80,width: 80,),

                                ),
                              const Gap(10),

                              GestureDetector(
                                onTap: () {

                                  mainDashboardController.toggleBottomSheet();

                                },
                                child: Text("Edit Picture",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColor.appPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize

                                  ),
                                ),
                              ),
                              Gap(10),

                              GestureDetector(
                                onTap: () async {
                                  mainDashboardController.hideOrShowEachGrid(contentProvider, widget.index,hideTitle: !widget.hide,hideImage: !widget.hide);
                                  Navigator.pop(context);

                                  // await contentProvider.updateListDataItem(id: widget.id, itemIndex: widget.index,hideTitle:!widget.hide);
                                 // mainDashboardController.setGridSizedModel(contentProvider.allGridSizedModel[mainDashboardController.gridIndex],mainDashboardController.gridIndex);
                                 printLog("This is being pressed");
                                },
                                  child: Text( widget.hide==false? "Hide Word":"Unhide word",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColor.appPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize

                                  ),
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
                                          mainDashboardController.removeVideosFromList(index);
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
                  child: CustomBottomSheetVideo(
                    gridIndex: widget.gridIndex,
                    id: widget.id,
                    index: widget.index,),
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
                  child: CustomBottomSheet(
                    gridIndex: widget.gridIndex,
                    id:widget.id,
                    index: widget.index,

                  ),
                ),
            ],
          ),
    );
  }
}

class GrayNavBarOnEdit extends StatelessWidget {
  final MainDashboardController mainDashboardController;
  final ContentProvider contentProvider;
  const GrayNavBarOnEdit({
    super.key,
    required this.widget, required this.mainDashboardController, required this.contentProvider,
  });

  final EditPopOver widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.shadowColor2,
          borderRadius:BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          if(mainDashboardController.isEditPressed)
            GestureDetector(
              onTap:() async {
                mainDashboardController.isEditPressedFun(false);
                if(mainDashboardController.editTitleTextEditingController.text.isNotEmpty){
                  await contentProvider.updateListDataItem(id: widget.id, itemIndex: widget.index,title: mainDashboardController.editTitleTextEditingController.text);
                  mainDashboardController.setGridSizedModel(contentProvider.allGridSizedModel[mainDashboardController.gridIndex],mainDashboardController.gridIndex);
                  mainDashboardController.clearEditTitleControllerText();
                  Navigator.pop(context);

                }
              },
              child: Text("Done",

                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(
                  color: AppColor.blue,
                  fontSize: 15,

                  fontWeight: FontWeight.w600,
                ),),
            )
          else
            GestureDetector(
              onTap:() {
                mainDashboardController.isEditPressedFun(true);
                mainDashboardController.setEditTitleControllerText(widget.title);



              },
              child: Text("Edit",

                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(
                  color: AppColor.blue,
                  fontSize: 15,

                  fontWeight: FontWeight.w600,
                ),),
            ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(widget.title,
                  textAlign: TextAlign.center,

                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(
                    color: AppColor.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),),



              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text("cancel",
              textAlign: TextAlign.center,

              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(
                color: AppColor.blue,
                fontSize: 15,

                fontWeight: FontWeight.w600,
              ),),
          ),

        ],
      ),
    );
  }
}


