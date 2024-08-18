import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/app_strings.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';
import 'package:word_toob/views/widgets/tool_tip_widget.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {



  TextEditingController _controler =TextEditingController();

  @override

  Widget build(BuildContext context) {
       int gridSize = 5;

       List<Map<String,dynamic>> customDialogList=[
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
           "gridSizeX":6,
           "gridSizeY":10,
         },
         {"name":"84 words",
           "gridSizeX":12,
           "gridSizeY":7,
         },

       ];
       List<Map<String,dynamic>> addMap=[
         {
           "name":AppString.newBoard,
           "onTap":(){
             Navigator.pop(context);
             AppUtility.showCustomDialog(context: context, title: AppString.newBoard, list:customDialogList);
           }
         },
         {
           "name":"Duplicate Board",
           "onTap":(){}
         }

       ];


    double sizeWidth=context.width*0.02;

    return SafeArea(
      child: Scaffold(
      
        body: Consumer<MainDashboardController>(
          builder: (context, mainDashBoarState, child) =>
           GestureDetector(
             onTap: () {
               FocusScope.of(context).unfocus();

             },
             child: Column(
                children: [
              if(!mainDashBoarState.editPressed)
                NormalNavBar(addMap: addMap, sizeWidth: sizeWidth,value: mainDashBoarState,)
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
    // return Expanded(
    //   child: ResponsiveGridList(
    //     horizontalGridSpacing: 16, // Horizontal space between grid items
    //     verticalGridSpacing: 16, // Vertical space between grid items
    //     horizontalGridMargin: 50, // Horizontal space around the grid
    //     verticalGridMargin: 50, // Vertical space around the grid
    //     minItemWidth: 10  , // The minimum item width (can be smaller, if the layout constraints are smaller)
    //     minItemsPerRow: value.gridSizeY, // The minimum items to show in a single row. Takes precedence over minItemWidth
    //     maxItemsPerRow: value.gridSizeY, // The maximum items to show in a single row. Can be useful on large screens
    //     listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
    //     children: List.generate(value.gridSizeX * value.gridSizeY, (index) =>  Stack(
    //       children: [
    //         Builder(
    //           builder: (context) =>
    //               GestureDetector(
    //                 onTap: () {
    //                   value.setItemOnEditState(index,context,title: "Happy",picture: MyAssets.happy );
    //                 },
    //                 child: Container(
    //                     margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    //                     decoration: BoxDecoration(
    //                       color: AppColor.cardColor,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(color: Colors.white, width: 2),
    //                     ),
    //                     child: Center(
    //                       child: Padding(
    //                         padding:  EdgeInsets.symmetric(vertical:context.height*0.02,horizontal: context.width*0.01),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               "Happy",
    //                               style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //                                 color: AppColor.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: context.height*0.02, // Adjust the font size if necessary
    //                               ),
    //                             ),
    //                             SizedBox(height: context.height*0.01), // Add spacing between text and image
    //                             Flexible(
    //                               child: CachedNetworkImage(
    //
    //                                 errorWidget: (context, url, error) => CircularProgressIndicator(),
    //                                 imageUrl: MyAssets.happy,
    //                                 width: 100, // Adjust the width of the image if necessary
    //                                 height: 100, // Adjust the height of the image if necessary
    //                                 fit: BoxFit.fitHeight, // Adjust how the image fits inside the box
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //
    //                 ),
    //               ),
    //         ),
    //         if (value.itemClickeBool && value.itemClickedOnEditState != index)
    //           Builder(
    //             builder: (context) =>
    //                 GestureDetector(
    //                   onTap: () {
    //                     value.setItemOnEditState(index,context,title: "Happy",picture: MyAssets.happy);
    //
    //                   },
    //                   child: Container(
    //                     color: AppColor.lightBlue.withOpacity(0.5), // Light blue overlay with opacity
    //                   ),
    //                 ),
    //           ),
    //       ],
    //     ),) // The list of widgets in the list
    //   ),
    // );
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: value.gridSizeY,
              // mainAxisExtent:10,
              // mainAxisSpacing: 2.0,
              childAspectRatio: 1,
              // crossAxisSpacing: 2.0,
            ),
            itemCount: value.gridSizeX * value.gridSizeY,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Builder(
                    builder: (context) =>
                     GestureDetector(
                      onTap: () {
                        value.setItemOnEditState(index,context,title: "Happy",picture: MyAssets.happy );
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
                            padding:  EdgeInsets.symmetric(vertical:context.height*0.02,horizontal: context.width*0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Happy",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.height*0.02, // Adjust the font size if necessary
                                  ),
                                ),
                                SizedBox(height: context.height*0.01), // Add spacing between text and image
                                Flexible(
                                  child: CachedNetworkImage(

                                    errorWidget: (context, url, error) => CircularProgressIndicator(),
                                    imageUrl: MyAssets.happy,
                                    width: 100, // Adjust the width of the image if necessary
                                    height: 100, // Adjust the height of the image if necessary
                                    fit: BoxFit.fitHeight, // Adjust how the image fits inside the box
                                  ),
                                ),
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
                          value.setItemOnEditState(index,context,title: "Happy",picture: MyAssets.happy);

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
        ),
      ),
    );

  }
}

class NormalNavBar extends StatelessWidget {
  final MainDashboardController value;
  const NormalNavBar({
    super.key,
    required this.addMap,
    required this.sizeWidth, required this.value,
  });

  final List<Map<String, dynamic>> addMap;
  final double sizeWidth;

  @override
  Widget build(BuildContext context) {
    double fontSize=context.height*0.025;
    double iconSize=context.height*0.04;
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
                        Builder(
                          builder: (context) =>
                           IconButton(onPressed: () async {
                            AppUtility.popOver(context, ListItems(count:2 ,
                              content:addMap ,),
                              heightSize: context.height*0.9,
                              widthSize: context.width*0.6
                            );



                             }, icon: Icon(Icons.add,size: iconSize,)),
                        ),
                        Gap(sizeWidth),
                        Builder(
                          builder: (context) =>
                           GestureDetector(
                            onTap: () async{
                              AppUtility.popOver(context, ListItems(content: [],count: 0,));

                            },
                            child: Text("My Boards",style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                              fontSize:fontSize ,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                        Gap(sizeWidth),

                        IconButton(onPressed: () {

                          AppUtility.popOver(context, ListItems(count: 0,content: [],));

                        }, icon: Icon(Icons.mic,size: iconSize,)),
                      ],
                                           ),


                GestureDetector(
                  onTap: (){


                    // AppUtility.popOver(context,ListItems(content: [],count: 0,));
              },
                  child: Text("WordToob: First 25 Words",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize
                  )),
                ),

                Row(
                  children: [
                    Text("Games",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize
                    )),
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
                    Text("Settings",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize
                    )),
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

class EditWidget extends StatelessWidget {
  final MainDashboardController value;
  const EditWidget({
    super.key,
    required this.sizeWidth,
    required TextEditingController controler, required this.value,
  }) : _controler = controler;

  final double sizeWidth;
  final TextEditingController _controler;

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

                   },
                   child: Text("Hide All",style: Theme.of(context).textTheme.bodyMedium
                       ?.copyWith(
                     fontWeight: FontWeight.bold,
                     fontSize: fontSize,
                     color: AppColor.appPrimaryColor
                   ),),
                 ),
           Gap(sizeWidth+20),
           GestureDetector(
             onTap: () async{

             },
             child: Text("Show All",style: Theme.of(context).textTheme.bodyMedium
                 ?.copyWith(
               fontWeight: FontWeight.bold,
                 fontSize: fontSize,

                 color: AppColor.appPrimaryColor

             ),),
           ),
           Gap(sizeWidth+60),
           Flexible(



             child: CupertinoSearchTextField(

               padding: EdgeInsets.all(5),
               prefixIcon: Icon(Icons.search,size:iconSize+2,),

               style: TextStyle(fontSize: fontSize+3),
               decoration: BoxDecoration(

                 color: AppColor.white,

                 borderRadius: BorderRadius.circular(10)
               ),
               controller: _controler,

             ),
           ),
           Gap(sizeWidth+60),

           GestureDetector(
             onTap: () async{
               value.setDone();

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

