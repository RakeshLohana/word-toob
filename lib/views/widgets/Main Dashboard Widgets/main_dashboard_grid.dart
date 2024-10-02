
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:word_toob/common/app_constants/general.dart';

import '../../../app_providers/main_dashboard_controller.dart';
import '../../../common/app_constants/assets.dart';
import '../../../common/app_constants/route_strings.dart';
import '../../../source/models/grid_model.dart';
import '../../theme/app_color.dart';

class GridViewWidget extends StatefulWidget {
  final MainDashboardController value;
  const GridViewWidget({
    super.key, required this.value,
  });

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  double _scale = 1.0;

  bool _zoomIn = true;

  Duration _duration = Duration(seconds: 2);

  void _animateZoom() {
    setState(() {
      _scale = _zoomIn ? 3.0 : 1.0;
      _zoomIn = !_zoomIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: Stack(
        children: [
          ListView(
            children: [
              const Gap(5),
           if( widget.value.findTheWord)  Align(
                alignment: Alignment.center,
                child: Text(
                  "Find '${widget.value.gridSizedModel.listData?[widget.value.randomListIndex].title}'",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: context.height*0.03
                    ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.value.gridSizedModel.hideModel==false? Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  widget.value.gridSizedModel.gridSizeY??2,
                      childAspectRatio: 1,
                    ),
                    itemCount: widget.value.gridSizedModel.listData?.length,
                    itemBuilder: (context, index) {
                      final GridModel grid=widget.value.gridSizedModel.listData?[index]??GridModel();
                      final findTheWrongWord=!widget.value.findTheWordWrongList.contains(index);

                        return widget.value.findTheWord? Stack(
                          children: [
                            Builder(
                              builder: (context) =>
                                  GestureDetector(
                                    onTap: () {
                                      if(widget.value.targetFindWord==grid.title){
                                        widget.value.setFindWordImage(widget.value.targetFindWord==grid.title);
                                        _animateZoom();

                                      }else{
                                        widget.value.setFindTheWordWrongList(index);

                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: findTheWrongWord? AppColor.cardColor:AppColor.transparent,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color:findTheWrongWord? Colors.white:Colors.transparent, width: 2),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(vertical:context.height*0.02,horizontal: context.width*0.02),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  findTheWrongWord?grid.title??'?':"",
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: AppColor.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: context.height*0.028, // Adjust the font size if necessary
                                                  ),
                                                ),
                                                SizedBox(height: context.height*0.02), // Add spacing between text and image
                                                findTheWrongWord?   Flexible(
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

                          ],
                        ):


                        Stack(
                        children: [
                          Builder(
                            builder: (context) =>
                                GestureDetector(
                                  onTap: () {
                                    // value.setItemOnEditState(index,context,title: "Happy",picture: MyAssets.happy );
                                    widget.value.setItemOnEditState(
                                        hide: grid.hidetitle??false,
                                        index,context,title:grid.title??'' ,picture: grid.imagepath??"",id: widget.value.gridSizedModel.id??-1,videoPath: grid.videosPath??[],gridIndex: widget.value.gridIndex );
                                    if(!widget.value.editPressed){
                                      widget.value.setLottie();
                                      widget.value.flutterTts.speak(  grid.title??"nothing");
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
                                              widget.value.settingsWordOnlyShow==1?   Flexible(
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
                          if (widget.value.itemClickeBool && widget.value.itemClickedOnEditState != index)
                            Builder(
                              builder: (context) =>
                                  GestureDetector(
                                    onTap: () {
                                      widget.value.setItemOnEditState(
                                          hide: grid.hidetitle??false,
                                          gridIndex: widget.value.gridIndex,
                                          index,context,title: grid.title??"",picture:grid.imagepath??"",id:  widget.value.gridSizedModel.id??-1, videoPath: grid.videosPath??[]);

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
            ],
          ),
      if( widget. value.findWordImage)  Align(
        alignment: Alignment.center,
        child: AnimatedScale(
              scale: _scale, // Scale value for zoom
              duration: _duration, // Animation duration
              curve: Curves.easeInOut, // Animation curve
              child: Image.asset(
                 MyAssets.correct,
                width: 200,
                height: 200,
              ),
            ),
      ),
        ],
      ),
    );

  }
}
