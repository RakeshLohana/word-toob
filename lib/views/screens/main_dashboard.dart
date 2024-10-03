import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
import 'package:word_toob/views/widgets/Main%20Dashboard%20Widgets/main_dashboard_grid.dart';
import 'package:word_toob/views/widgets/Main%20Dashboard%20Widgets/nav_bar.dart';
import 'package:word_toob/views/widgets/bottom_sheet.dart';
import 'package:word_toob/views/widgets/custom_menu_widget.dart';
import 'package:word_toob/views/widgets/tool_tip_widget.dart';

import '../../common/app_constants/general.dart';
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











  void saveData(){
      _contentProvider.saveAllGridSizedModel(gridSizedModelList:gridModelList,contenProvider: _contentProvider );


  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(()=>saveData());
    _mainDashBoard.initSpeechToText();
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
                NormalNavBar(addMap: addMap, sizeWidth: sizeWidth,value: mainDashBoarState,contentProvider: contentState,menuController: MenuController(),)
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




class LeftRow extends StatelessWidget {
  const LeftRow({
    super.key,
    required this.addMap,
    required this.iconSize,
    required this.sizeWidth,
    required this.menuController2,
    required this.contentProvider,
    required this.value,
    required this.fontSize,
  });

  final List<Map<String, dynamic>> addMap;
  final double iconSize;
  final double sizeWidth;
  final MenuController menuController2;
  final ContentProvider contentProvider;
  final MainDashboardController value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [

      PlusButton(addMap: addMap, iconSize: iconSize),

      Gap(sizeWidth),
      MyBoardsButton(menuController: menuController2, contentProvider: contentProvider, value: value, fontSize: fontSize),


      Gap(sizeWidth),

      GestureDetector(
        onTap: () {
          value.setSpeechToText();

        },
        child: Container(
          decoration: BoxDecoration(
              color: value.speechToTextCheck? AppColor.blue:Colors.transparent,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(5),
          child: Icon(Icons.mic,size: iconSize,color:value.speechToTextCheck?AppColor.white:AppColor.blue),
        ),
      ),
      Gap(sizeWidth),
      if(value.lottie||value.speechToTextCheck) Lottie.asset('assets/v_player.json',animate: value.lottie||value.speechToTextCheck, ),

    ],
                         );
  }
}

class CenterTitle extends StatelessWidget {
  const CenterTitle({
    super.key,
    required this.value,
    required this.fontSize,
  });

  final MainDashboardController value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        },
      child: Text(value.gridSizedModel.title??"",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: fontSize
      )),
    );
  }
}

class PlusButton extends StatelessWidget {
  const PlusButton({
    super.key,
    required this.addMap,
    required this.iconSize,
  });

  final List<Map<String, dynamic>> addMap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CustomMenuAnchor(
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

        ))

        , titleWidget:Icon(Icons.add,size: iconSize,) );
  }
}

class MyBoardsButton extends StatelessWidget {
  const MyBoardsButton({
    super.key,
    required this.menuController,
    required this.contentProvider,
    required this.value,
    required this.fontSize,
  });

  final MenuController menuController;
  final ContentProvider contentProvider;
  final MainDashboardController value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return CustomMenuAnchor(
      menuController:menuController,


      menuItems:
    List.generate(contentProvider.allGridSizedModel.length, (index){

      return ListTile(
        onTap: () {
          value.setGridSize(contentProvider.allGridSizedModel[index].gridSizeX??1, contentProvider.allGridSizedModel[index].gridSizeY??2);
          value.setGridSizedModel(contentProvider.allGridSizedModel[index],value.gridIndex);

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
               fontSize:fontSize , fontWeight: FontWeight.bold,),),);
  }
}

class RightRow extends StatelessWidget {
  const RightRow({
    super.key,
    required this.menuController,
    required this.gameMap,
    required this.fontSize,
    required this.sizeWidth,
    required this.value,
    required this.gap,
  });

  final MenuController menuController;
  final List<Map<String, dynamic>> gameMap;
  final double fontSize;
  final double sizeWidth;
  final MainDashboardController value;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        CustomMenuAnchor(

          menuController:menuController,


          menuItems:
          List.generate(2, (index){

            return ListTile(
              onTap:gameMap[index]["onTap"],
              visualDensity: VisualDensity(horizontal: -4,vertical: -4),
              title: Text(gameMap[index]["name"]),

            );
          }
          )
          , titleWidget: Text("Games",style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(
          fontSize:fontSize ,
          fontWeight: FontWeight.bold,),),),




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

        SettingButton(fontSize: fontSize, gap: gap, value: value),


        Gap(sizeWidth),
        HelpButton(fontSize: fontSize),
      ],
    );
  }
}

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => BottomSheetContent(),
        );                      },
      child: Text("Help",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: fontSize
      )),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.fontSize,
    required this.gap,
    required this.value,
  });

  final double fontSize;
  final double gap;
  final MainDashboardController value;

  @override
  Widget build(BuildContext context) {
    return CustomMenuAnchor(menuItems: [
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

