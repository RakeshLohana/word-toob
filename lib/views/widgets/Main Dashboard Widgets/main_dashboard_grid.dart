
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_providers/main_dashboard_controller.dart';
import '../../../common/app_constants/assets.dart';
import '../../../common/app_constants/route_strings.dart';
import '../../../source/models/grid_model.dart';
import '../../theme/app_color.dart';

class GridViewWidget extends StatelessWidget {
  final MainDashboardController value;
  const GridViewWidget({
    super.key, required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: value.gridSizedModel.hideModel==false? Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:  value.gridSizedModel.gridSizeY??2,
              childAspectRatio: 1,
            ),
            itemCount: value.gridSizedModel.listData?.length,
            itemBuilder: (context, index) {
              final GridModel grid=value.gridSizedModel.listData?[index]??GridModel();
              return Stack(
                children: [
                  Builder(
                    builder: (context) =>
                        GestureDetector(
                          onTap: () {
                            // value.setItemOnEditState(index,context,title: "Happy",picture: MyAssets.happy );
                            value.setItemOnEditState(
                                hide: grid.hidetitle??false,
                                index,context,title:grid.title??'' ,picture: grid.imagepath??"",id: value.gridSizedModel.id??-1,videoPath: grid.videosPath??[],gridIndex: value.gridIndex );
                            if(!value.editPressed){
                              value.setLottie();
                              value.flutterTts.speak(  grid.title??"nothing");
                              if(grid.videosPath?.isNotEmpty??true   && grid.videosPath!.length>1){
                                var rand=Random().nextInt(grid.videosPath?.length??0+1);
                                Navigator.pushNamed(context, RouteStrings.videoPlayer,arguments: grid.videosPath?[rand]);
                              }

                            }




                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColor.cardColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical:context.height*0.02,horizontal: context.width*0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        grid.title??'?',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: context.height*0.028, // Adjust the font size if necessary
                                        ),
                                      ),
                                      SizedBox(height: context.height*0.02), // Add spacing between text and image
                                      value.settingsWordOnlyShow==1?   Flexible(
                                        child: grid.imagepath!=null? grid.imagepath!.contains("assets")?
                                        Image.asset(grid.imagepath!,height: context.height*0.5,width: 100,): Image.file(File(grid.imagepath!),height: context.height*0.5,width: 100,):Container(),

                                      ):Container(),
                                    ],
                                  ),
                                ),
                              )

                          ),
                        ),
                  ),
                  if (value.itemClickeBool && value.itemClickedOnEditState != index)
                    Builder(
                      builder: (context) =>
                          GestureDetector(
                            onTap: () {
                              value.setItemOnEditState(
                                  hide: grid.hidetitle??false,
                                  gridIndex: value.gridIndex,
                                  index,context,title: grid.title??"",picture:grid.imagepath??"",id:  value.gridSizedModel.id??-1, videoPath: grid.videosPath??[]);

                            },
                            child: Container(
                              color: AppColor.lightBlue.withOpacity(0.5), // Light blue overlay with opacity
                            ),
                          ),
                    ),
                ],
              );
            },
          ),
        ):Container(),
      ),
    );

  }
}
