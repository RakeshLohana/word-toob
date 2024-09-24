import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:word_toob/app_providers/content_provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/app_strings.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/app_constants/route_strings.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/dependency_inject.dart';
import 'package:word_toob/source/models/grid_model.dart';
import 'package:word_toob/views/theme/app_color.dart';
import 'package:word_toob/views/widgets/custom_menu_widget.dart';
import 'package:word_toob/views/widgets/tool_tip_widget.dart';

import '../../source/models/grid_size_model.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {



  TextEditingController _controler =TextEditingController();

  final _contentProvider=sl<ContentProvider>();
  final _mainDashBoard=sl<MainDashboardController>();




  List<GridSizeModel> gridModelList=[
   ///emotions
    GridSizeModel(title: AppString.emotions,gridSizeX: 4,gridSizeY: 4,hideModel: false,

        listData: [
          GridModel(title: AppString.happy,hideImage: false,hidetitle: false,imagepath:MyAssets.happyP,videosPath: [
            MyAssets.happyVideo1,
            MyAssets.happyVideo2

          ]),
          GridModel(title:AppString.love,hideImage: false,hidetitle: false,imagepath: MyAssets.love,videosPath:  [
            MyAssets.love1,
            MyAssets.love2

          ]),
          GridModel(title: AppString.excited,hideImage: false,hidetitle: false,imagepath: MyAssets.excited,videosPath:  [
            MyAssets.excited1,
            MyAssets.excited2

          ]),
          GridModel(title: AppString.surprised,hideImage: false,hidetitle: false,imagepath: MyAssets.surprised,videosPath:  [
            MyAssets.surprised1,
            MyAssets.surprised2

          ]),
          GridModel(title: AppString.scared,hideImage: false,hidetitle: false,imagepath: MyAssets.scared,videosPath:  [
            MyAssets.scared1,
            MyAssets.scared2

          ]),
          GridModel(title: AppString.frustrated,hideImage: false,hidetitle: false,imagepath: MyAssets.frustrated,videosPath:  [
            MyAssets.frustrated1,
            MyAssets.frustrated2

          ]),
          GridModel(title: AppString.mad,hideImage: false,hidetitle: false,imagepath: MyAssets.mad,videosPath:  [
            MyAssets.mad1,
            MyAssets.mad2

          ]),
          GridModel(title: AppString.sad,hideImage: false,hidetitle: false,imagepath: MyAssets.sad,videosPath: [
            MyAssets.sad1,
            MyAssets.sad2

          ]),
        ]
    ),

    ///First 25 words
    GridSizeModel(title:AppString.first25Words ,gridSizeX: 5,gridSizeY: 5,hideModel: false,

        listData: [
          GridModel(title: AppString.mommy,hideImage: false,hidetitle: false,imagepath:MyAssets.mommy,videosPath: [


          ]),
          GridModel(title: AppString.yes,hideImage: false,hidetitle: false,imagepath: MyAssets.yes,videosPath: []),
          GridModel(title: AppString.bye,hideImage: false,hidetitle: false,imagepath: MyAssets.bye,videosPath: []),
          GridModel(title: AppString.hello,hideImage: false,hidetitle: false,imagepath: MyAssets.hello,videosPath: []),
          GridModel(title: AppString.no,hideImage: false,hidetitle: false,imagepath: MyAssets.no,videosPath: []),
          GridModel(title: AppString.eye,hideImage: false,hidetitle: false,imagepath: MyAssets.eye,videosPath: []),
          GridModel(title: AppString.ball,hideImage: false,hidetitle: false,imagepath: MyAssets.ball,videosPath: []),
          GridModel(title: AppString.thankYou,hideImage: false,hidetitle: false,imagepath: MyAssets.thankYou,videosPath: []),
          GridModel(title: AppString.book,hideImage: false,hidetitle: false,imagepath: MyAssets.book,videosPath: []),
          GridModel(title: AppString.nose,hideImage: false,hidetitle: false,imagepath: MyAssets.nose,videosPath: []),
          GridModel(title: AppString.daddy,hideImage: false,hidetitle: false,imagepath: MyAssets.daddy,videosPath: []),
          GridModel(title: AppString.cookie,hideImage: false,hidetitle: false,imagepath: MyAssets.cookie,videosPath: []),
          GridModel(title: AppString.hat,hideImage: false,hidetitle: false,imagepath: MyAssets.hat,videosPath: []),
          GridModel(title: AppString.shoe,hideImage: false,hidetitle: false,imagepath: MyAssets.shoe,videosPath: []),
          GridModel(title: AppString.more,hideImage: false,hidetitle: false,imagepath: MyAssets.more,videosPath: []),
          GridModel(title: AppString.cat,hideImage: false,hidetitle: false,imagepath: MyAssets.cat,videosPath: []),
          GridModel(title: AppString.dog,hideImage: false,hidetitle: false,imagepath: MyAssets.dog,videosPath: []),
          GridModel(title: AppString.baby,hideImage: false,hidetitle: false,imagepath: MyAssets.baby,videosPath: []),
          GridModel(title: AppString.car,hideImage: false,hidetitle: false,imagepath: MyAssets.car,videosPath: []),
          GridModel(title: AppString.bath,hideImage: false,hidetitle: false,imagepath: MyAssets.bath,videosPath: []),
          GridModel(title: AppString.allGone,hideImage: false,hidetitle: false,imagepath: MyAssets.allGone,videosPath: []),
          GridModel(title: AppString.bananan,hideImage: false,hidetitle: false,imagepath: MyAssets.banana,videosPath: []),
          GridModel(title: AppString.milk,hideImage: false,hidetitle: false,imagepath: MyAssets.milk,videosPath: []),
          GridModel(title: AppString.juice,hideImage: false,hidetitle: false,imagepath: MyAssets.juice,videosPath: []),
          GridModel(title: AppString.hot,hideImage: false,hidetitle: false,imagepath: MyAssets.hot,videosPath: []),

        ]
    ),

    ///Alphabets
    GridSizeModel(title:AppString.alphabetBoard ,gridSizeX:5 ,gridSizeY: 6,hideModel: false,

        listData: [
          GridModel(title: AppString.a,hideImage: false,hidetitle: false,imagepath:MyAssets.a,videosPath: []),
          GridModel(title: AppString.b,hideImage: false,hidetitle: false,imagepath: MyAssets.b,videosPath: []),
          GridModel(title: AppString.c,hideImage: false,hidetitle: false,imagepath: MyAssets.c,videosPath: []),
          GridModel(title: AppString.d,hideImage: false,hidetitle: false,imagepath: MyAssets.d,videosPath: []),
          GridModel(title: AppString.e,hideImage: false,hidetitle: false,imagepath: MyAssets.e,videosPath: []),
          GridModel(title: AppString.f,hideImage: false,hidetitle: false,imagepath: MyAssets.f,videosPath: []),
          GridModel(title: AppString.g,hideImage: false,hidetitle: false,imagepath: MyAssets.g,videosPath: []),
          GridModel(title: AppString.h,hideImage: false,hidetitle: false,imagepath: MyAssets.h,videosPath: []),
          GridModel(title: AppString.i,hideImage: false,hidetitle: false,imagepath: MyAssets.i,videosPath: []),
          GridModel(title: AppString.j,hideImage: false,hidetitle: false,imagepath: MyAssets.j,videosPath: []),
          GridModel(title: AppString.k,hideImage: false,hidetitle: false,imagepath: MyAssets.k,videosPath: []),
          GridModel(title: AppString.l,hideImage: false,hidetitle: false,imagepath: MyAssets.l,videosPath: []),
          GridModel(title: AppString.m,hideImage: false,hidetitle: false,imagepath: MyAssets.m,videosPath: []),
          GridModel(title: AppString.n,hideImage: false,hidetitle: false,imagepath: MyAssets.n,videosPath: []),
          GridModel(title: AppString.o,hideImage: false,hidetitle: false,imagepath: MyAssets.o,videosPath: []),
          GridModel(title: AppString.p,hideImage: false,hidetitle: false,imagepath: MyAssets.p,videosPath: []),
          GridModel(title: AppString.q,hideImage: false,hidetitle: false,imagepath: MyAssets.q,videosPath: []),
          GridModel(title: AppString.r,hideImage: false,hidetitle: false,imagepath: MyAssets.r,videosPath: []),
          GridModel(title: AppString.s,hideImage: false,hidetitle: false,imagepath: MyAssets.s,videosPath: []),
          GridModel(title: AppString.t,hideImage: false,hidetitle: false,imagepath: MyAssets.t,videosPath: []),
          GridModel(title: AppString.u,hideImage: false,hidetitle: false,imagepath: MyAssets.u,videosPath: []),
          GridModel(title: AppString.v,hideImage: false,hidetitle: false,imagepath: MyAssets.v,videosPath: []),
          GridModel(title: AppString.w,hideImage: false,hidetitle: false,imagepath: MyAssets.w,videosPath: []),
          GridModel(title: AppString.x,hideImage: false,hidetitle: false,imagepath: MyAssets.x,videosPath: []),
          GridModel(title: AppString.y,hideImage: false,hidetitle: false,imagepath: MyAssets.y,videosPath: []),
          GridModel(title: AppString.z,hideImage: false,hidetitle: false,imagepath: MyAssets.z,videosPath: []),



        ]
    ),

    ///numbers
    GridSizeModel(title:AppString.numbers ,gridSizeX:5 ,gridSizeY:5 ,hideModel: false,

        listData: [
          GridModel(title: AppString.zero,hideImage: false,hidetitle: false,imagepath:MyAssets.zero,videosPath: []),
          GridModel(title: AppString.one,hideImage: false,hidetitle: false,imagepath:MyAssets.one,videosPath: []),
          GridModel(title: AppString.two,hideImage: false,hidetitle: false,imagepath:MyAssets.two,videosPath: []),
          GridModel(title: AppString.three,hideImage: false,hidetitle: false,imagepath:MyAssets.three,videosPath: []),
          GridModel(title: AppString.four,hideImage: false,hidetitle: false,imagepath:MyAssets.four,videosPath: []),
          GridModel(title: AppString.five,hideImage: false,hidetitle: false,imagepath:MyAssets.five,videosPath: []),
          GridModel(title: AppString.six,hideImage: false,hidetitle: false,imagepath:MyAssets.six,videosPath: []),
          GridModel(title: AppString.seven,hideImage: false,hidetitle: false,imagepath:MyAssets.seven,videosPath: []),
          GridModel(title: AppString.eight,hideImage: false,hidetitle: false,imagepath:MyAssets.eight,videosPath: []),
          GridModel(title: AppString.nine,hideImage: false,hidetitle: false,imagepath:MyAssets.nine,videosPath: []),
          GridModel(title: AppString.ten,hideImage: false,hidetitle: false,imagepath:MyAssets.ten,videosPath: []),




        ]
    ),

  ];






  void saveData(){
      _contentProvider.saveAllGridSizedModel(gridSizedModelList:gridModelList,contenProvider: _contentProvider );


  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(()=>saveData());
   Future. microtask(()=>_mainDashBoard.getCurrentSelectedGridSizedModel(_contentProvider));
    _mainDashBoard.initTextToSpeech();
  }



  @override

  Widget build(BuildContext context) {


    List<Map<String,dynamic>> customDialogList=[
      {"name":"Emotions",
        "gridSizeX":4,
        "gridSizeY":4,
      },

      {"name":"First 25 Words",
        "gridSizeX":5,
        "gridSizeY":5,
      },
      {"name":"Alphabets",
        "gridSizeX":5,
        "gridSizeY":6,
      },
      {"name":"Numbers",
        "gridSizeX":5,
        "gridSizeY":5,
      },
      {"name":"2 words",
        "gridSizeX":1,
        "gridSizeY":2,
      },
      {"name":"4 words",
        "gridSizeX":2,
        "gridSizeY":2,
      },
      {"name":"6 words",
        "gridSizeX":2,
        "gridSizeY":3,
      },
      {"name":"12 words",
        "gridSizeX":3,
        "gridSizeY":4,
      },
      {"name":"15 words",
        "gridSizeX":3,
        "gridSizeY":5,
      },
      {"name":"25 words",
        "gridSizeX":5,
        "gridSizeY":5,
      },
      {"name":"60 words",
        "gridSizeX":10,
        "gridSizeY":6,
      },
      {"name":"84 words",
        "gridSizeX":12,
        "gridSizeY":7,
      },

    ];

    List<GridSizeModel> gridSizeModelInitialized = customDialogList.map((item) {
      return GridSizeModel(
        gridSizeX: item['gridSizeX'],
        gridSizeY: item['gridSizeY'],
        currentSelected: false,
        title: item['name'],
        hideModel: false,
        listData: List.generate(
          item['gridSizeX']*item['gridSizeY'],
              (index) => GridModel(


              ), // Generate your GridModel objects as needed
        ),
      );
    })
        .toList();






       List<Map<String,dynamic>> addMap=[
         {
           "name":AppString.newBoard,
           "onTap":(){
             _contentProvider.getAllGridSizeModel();
             AppUtility.showCustomDialog(context: context, title: AppString.newBoard, list:gridSizeModelInitialized.reversed.toList(),
               contentProvider: _contentProvider 



             );
           }
         },
         {
           "name":"Duplicate Board",
           "onTap":(){
             _contentProvider.saveGridSizedModel(gridSizedModel:_mainDashBoard.duplicateGridSizedModel, );
           }
         }

       ];


    double sizeWidth=context.width*0.02;

    return SafeArea(
      child: Scaffold(
      
        body: Consumer2<MainDashboardController,ContentProvider>(
          builder: (context, mainDashBoarState, contentState,child) =>
           GestureDetector(
             onTap: () {
               FocusScope.of(context).unfocus();

             },
             child: Column(
                children: [
              if(!mainDashBoarState.editPressed)
                NormalNavBar(addMap: addMap, sizeWidth: sizeWidth,value: mainDashBoarState,contentProvider: contentState,)
                else
                  EditWidget(sizeWidth: sizeWidth, controler: _controler,value: mainDashBoarState,),
                  GridViewWidget(value:mainDashBoarState ,),
                ],
              ),
           ),
        ),
      
      
      ),
    );
  }
}

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
                        value.setItemOnEditState(index,context,title:grid.title??'' ,picture: grid.imagepath??MyAssets.happy,id: value.gridSizedModel.id??-1,videoPath: grid.videosPath??[] );
                        if(!value.editPressed){
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
                          value.setItemOnEditState(index,context,title: grid.title??"",picture:grid.imagepath??"",id:  value.gridSizedModel.id??-1, videoPath: grid.videosPath??[]);

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

class NormalNavBar extends StatelessWidget {
  final MainDashboardController value;
  final ContentProvider contentProvider;
   NormalNavBar({
    super.key,
    required this.addMap,
    required this.sizeWidth, required this.value, required this.contentProvider,
  });

  final List<Map<String, dynamic>> addMap;
  final double sizeWidth;
  MenuController menuController=MenuController();

  @override
  Widget build(BuildContext context) {
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




                      Row(
                      children: [

                        CustomMenuAnchor(
                            menuItems:List.generate(addMap.length,(index)=> GestureDetector(
                              onTap: addMap[index]["onTap"],
                              child: ListTile(
                                tileColor:index==0? AppColor.shadowColor:AppColor.white,
                                title: Text(addMap[index]["name"],

                                        style: Theme.of(context).textTheme.bodyLarge
                                            ?.copyWith(
                                          color: AppColor.blue,

                                          fontWeight: FontWeight.bold,
                                        ),),
                              ),
                              // child: Container(
                              //   color: index==0? AppColor.shadowColor:AppColor.white,
                              //   width: double.infinity,
                              //   padding: EdgeInsets.all(10),
                              //   margin: EdgeInsets.symmetric(vertical: 1),
                              //   child: Center(
                              //     child: Text(addMap[index]["name"],
                              //
                              //       style: Theme.of(context).textTheme.bodySmall
                              //           ?.copyWith(
                              //         color: AppColor.blue,
                              //
                              //         fontWeight: FontWeight.bold,
                              //       ),),
                              //   ),
                              //
                              // ),
                            ))

                            , titleWidget:Icon(Icons.add,size: iconSize,) ),

                        Gap(sizeWidth),
                        CustomMenuAnchor(
                          menuController:menuController,


                          menuItems:
                        List.generate(contentProvider.allGridSizedModel.length, (index){

                          return ListTile(
                            onTap: () {
                              value.setGridSize(contentProvider.allGridSizedModel[index].gridSizeX??1, contentProvider.allGridSizedModel[index].gridSizeY??2);
                              value.setGridSizedModel(contentProvider.allGridSizedModel[index]);

                              int count=contentProvider.allGridSizedModel[index].duplicateCount+1;


                              GridSizeModel gridSizeModel=GridSizeModel(
                                currentSelected: true,
                                duplicateCount: count,
                                listData: contentProvider.allGridSizedModel[index].listData,
                                gridSizeY: contentProvider.allGridSizedModel[index].gridSizeY,


                                gridSizeX: contentProvider.allGridSizedModel[index].gridSizeX,
                                title: "${contentProvider.allGridSizedModel[index].title} copy ${count} ",

                              );
                              count=0;

                              value.makeDuplicateGridSizedModel(gridSizeModel);
                              menuController.close();

                            },
                            visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                            title: Text(contentProvider.allGridSizedModel[index].title??""),

                          );
                                                              }
                        )
                          , titleWidget: Text("My Boards",style: Theme.of(context).textTheme.bodySmall
                         ?.copyWith(
                                   fontSize:fontSize , fontWeight: FontWeight.bold,),),),


                        Gap(sizeWidth),

                        IconButton(onPressed: () {

                        }, icon: Icon(Icons.mic,size: iconSize,)),
                      ],
                                           ),


                GestureDetector(
                  onTap: (){

                    },
                  child: Text(value.gridSizedModel.title??"",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize
                  )),
                ),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        contentProvider.getAllGridSizeModel();
                      },
                      child: Text("Games",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize
                      )),
                    ),
                    Gap(sizeWidth),
                    GestureDetector(
                      onTap: () {
                        value.setEdit(true);
                      },
                      child: Text("Edit",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      )),
                    ),
                    Gap(sizeWidth),

                    CustomMenuAnchor(menuItems: [
                      CustomMenuItemButton(child:        Container(
                        width: context.width*0.73,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Text("Settings",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 20,
                                  color: AppColor.appPrimaryColor
                              ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Gap(25),
                                  Text("Tiles",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: fontSize+8,
                                      color:AppColor.appPrimaryColor.withOpacity(0.5)
                                  )),
                                  Gap(gap),

                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      children: [
                                       GestureDetector(
                                         onTap: () {
                                           value.wordsOnlyShowSettings(1);
                                         },
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text("Symbols & Word",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                 fontSize: fontSize+10,
                                                 color:AppColor.appPrimaryColor
                                             )) ,
                                           value.settingsWordOnlyShow==1?  Icon(Icons.check,color: AppColor.green,):Container()
                                           ],
                                         ),
                                       ),
                                        Gap(gap),
                                       GestureDetector(
                                         onTap: () {
                                           value.wordsOnlyShowSettings(2);
                                         },
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                           children: [
                                             Text("Word Only",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                 fontSize: fontSize+10,
                                                 color:AppColor.appPrimaryColor
                                             )) ,
                                           value.settingsWordOnlyShow==2?  Icon(Icons.check,color: AppColor.green,):Container()

                                           ],
                                         ),
                                       ),



                                      ],
                                    ),
                                  ),
                                  Gap(gap),


                                  Text("SPEECH OUTPUT",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: fontSize+5,
                                      color:AppColor.appPrimaryColor.withOpacity(0.5)
                                  )),
                                  Gap(gap),

                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Use Speech",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontSize: fontSize+10,
                                                color:AppColor.appPrimaryColor
                                            )) ,
                                            Switch(
                                              activeColor: AppColor.white,
                                                activeTrackColor: AppColor.green,
                                                value: value.useSpeech, onChanged: (valueNew){
                                                value.useSpeechFunction();

                                            })
                                          ],
                                        ),
                                        Gap(10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Voice",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontSize: fontSize+10,
                                                color:AppColor.appPrimaryColor
                                            )),
                                            Text("English (United States)",
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontSize: fontSize+5,
                                            
                                                color:AppColor.appPrimaryColor
                                            )) ,


                                          ],
                                        ),






                                      ],
                                    ),
                                  ),
                                  Gap(gap),

                                  Text("SPEECH RECOGNITION",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: fontSize+5,
                                      color:AppColor.appPrimaryColor.withOpacity(0.5)
                                  )),
                                  Gap(gap),

                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("English ",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontSize: fontSize+10,
                                                color:AppColor.appPrimaryColor
                                            )) ,
                                            Icon(Icons.check,color: AppColor.green,)
                                          ],
                                        ),
                                        Gap(gap),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Spanish",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontSize: fontSize+10,
                                                color:AppColor.appPrimaryColor
                                            )) ,
                                            Icon(Icons.check,color: AppColor.green,)

                                          ],
                                        ),



                                      ],
                                    ),
                                  ),
                                  Gap(gap),


                                  Text("GAME OPTIONS",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: fontSize+8,
                                      color:AppColor.appPrimaryColor.withOpacity(0.5)
                                  )),
                                  Gap(gap),


                                  Text("Find The Word",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: fontSize+10,
                                      color:AppColor.appPrimaryColor.withOpacity(0.5)
                                  )),



                                ],
                              ),
                            ],
                          ),
                        ),
                      ),)
                    ], titleWidget:  Text("Settings",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize
                    )),
                    ),

                    // GestureDetector(
                    //   onTap: () {
                    //
                    //
                    //   },
                    //   child: Text("Settings",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: fontSize
                    //   )),
                    // ),
                    Gap(sizeWidth),
                    Text("Help",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize
                    )),
                  ],
                )
              ],
                               ),

        );
  }
}

class EditWidget extends StatefulWidget {
  final MainDashboardController value;
  const EditWidget({
    super.key,
    required this.sizeWidth,
    required TextEditingController controler, required this.value,
  }) : _controler = controler;

  final double sizeWidth;
  final TextEditingController _controler;

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  @override
  Widget build(BuildContext context) {
    double fontSize=context.height*0.025;
    double iconSize=context.height*0.04;
    return Container(
     color: AppColor.yellow,
     padding: EdgeInsets.symmetric(horizontal:AppUtility.horizontalPadding*0.5,vertical:AppUtility.verticalPadding*0.3),
     child:
     SizedBox(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           GestureDetector(
                   onTap: () {
                       widget.value.setHideButton();




                   },
                   child: Text("Hide All",style: Theme.of(context).textTheme.bodyMedium
                       ?.copyWith(
                     fontWeight: FontWeight.bold,
                     fontSize: fontSize,
                     color: AppColor.appPrimaryColor
                   ),),
                 ),
           Gap(widget.sizeWidth+20),
           GestureDetector(
             onTap: () async{
               widget.value.showAllButton();

             },
             child: Text("Show All",style: Theme.of(context).textTheme.bodyMedium
                 ?.copyWith(
               fontWeight: FontWeight.bold,
                 fontSize: fontSize,

                 color: AppColor.appPrimaryColor

             ),),
           ),
           Gap(widget.sizeWidth+60),
           Flexible(



             child: CupertinoSearchTextField(


               padding: EdgeInsets.all(5),
               prefixIcon: Icon(Icons.search,size:iconSize+2,),

               style: TextStyle(fontSize: fontSize+3),
               decoration: BoxDecoration(

                 color: AppColor.white,

                 borderRadius: BorderRadius.circular(10)
               ),
               controller: widget._controler,

             ),
           ),
           Gap(widget.sizeWidth+60),

           GestureDetector(
             onTap: () async{
               widget.value.setDone();

             },
             child: Text("Done",style: Theme.of(context).textTheme.bodyMedium
                 ?.copyWith(
               fontWeight: FontWeight.bold,
                 fontSize: fontSize,
                 color: AppColor.appPrimaryColor

             ),),
           )





         ],
       ),
     ),


                 );
  }
}





class ListItems extends StatelessWidget {
  final int count;
  final List<Map<String,dynamic>> content;
  const ListItems({Key? key, required this.count, required this.content,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) => GestureDetector(
        onTap: content[index]["onTap"],
        child: Container(
          color: AppColor.shadowColor,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 1),
          child: Center(
            child: Text(content[index]["name"],

              style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(
              color: AppColor.blue,

              fontWeight: FontWeight.bold,
            ),),
          ),

        ),
      ),),
    );
  }
}

