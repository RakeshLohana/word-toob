import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:popover/popover.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/views/theme/app_color.dart';
import 'package:word_toob/views/widgets/custom_bottom_sheet.dart';
import 'package:word_toob/views/widgets/edit_pop_over.dart';

class MainDashboardController extends ChangeNotifier{

  int _gridSizeX=1;
  int get gridSizeX=>_gridSizeX;

  int _gridSizeY=2;
  int get gridSizeY=>_gridSizeY;

  bool _editPressed=false;
  bool get editPressed=>_editPressed;


  int? _itemClickedOnEditState;
  int? get itemClickedOnEditState=>_itemClickedOnEditState;


  bool _itemClickeBool=false;
  bool get itemClickeBool=>_itemClickeBool;


  bool _showBottomSheet = false;
  bool get showBottomSheet  => _showBottomSheet;

  bool _showBottomSheetVideo = false;
  bool get showBottomSheetVideo  => _showBottomSheetVideo;


  List<String> _videos=[];
  List<String> get videos=>_videos;



  String _imagePath="";
  String get imagePath=>_imagePath;

   void addVideoToList(String videoPath){
     _videos.add(videoPath);
     notifyListeners();
   }




   getImagePath(String imagePath){
     _imagePath=imagePath;
     print(_imagePath);
     notifyListeners();
   }


  void toggleBottomSheet() {
    _showBottomSheet = !_showBottomSheet;
    notifyListeners();
  }


  void toggleBottomSheetVideo() {
    _showBottomSheetVideo = !_showBottomSheetVideo;
    notifyListeners();
  }

  void toggleBottomSheetOff() {
    _showBottomSheet = false;
    notifyListeners();
  }

  void toggleBottomSheetOffVideo() {
    _showBottomSheetVideo = false;
    notifyListeners();
  }



  void setEdit(bool value){
    _editPressed=value;
    notifyListeners();
  }

  void setDone(){
    _editPressed=false;
    _itemClickedOnEditState=null;
    _itemClickeBool=false;
    notifyListeners();
  }


  void setGridSize(int sizeX,int sizeY){
    _gridSizeX=sizeX;
    _gridSizeY=sizeY;
    notifyListeners();
  }



  void setItemOnEditState(int index,BuildContext context,{required String title,required String picture, }) {

    if (_editPressed) {
      _itemClickedOnEditState = index;
      _itemClickeBool = true;
      _showBottomSheetVideo=false;
      _showBottomSheet=false;
      AppUtility.popOver(context,EditPopOver(title: title, picture: picture),
          direct: PopoverDirection.bottom  ,heightSize: context.height*0.9,widthSize: context.width*0.8);


    }

    notifyListeners();
  }




}