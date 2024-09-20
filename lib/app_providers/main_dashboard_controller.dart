import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:popover/popover.dart';
import 'package:word_toob/app_providers/content_provider.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/source/models/grid_model.dart';
import 'package:word_toob/source/models/grid_size_model.dart';
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

  bool _isEditPressed = false;
  bool get isEditPressed  => _isEditPressed;


  int _settingsWordOnlyShow=1 ;
  int get settingsWordOnlyShow  => _settingsWordOnlyShow;


  bool _useSpeech=true ;
  bool get useSpeech  => _useSpeech;


  List<String> _videos=[];
  List<String> get videos=>_videos;


  List<GridModel> _gridItemMain=[];
  List<GridModel> get gridItemMain=>_gridItemMain;



  GridSizeModel _gridSizedModel=GridSizeModel();
  GridSizeModel get gridSizedModel=>_gridSizedModel;



  GridSizeModel _duplicateGridSizedModel=GridSizeModel();
  GridSizeModel get duplicateGridSizedModel=>_duplicateGridSizedModel;



  FlutterTts _flutterTts = FlutterTts();
  FlutterTts  get flutterTts=>_flutterTts;

  List<Map> _voices = [];
  Map? _currentVoice;

  int? _currentWordStart;
  int? get currentWordStart=> _currentWordStart;


   int?   _currentWordEnd;
   int?   get currentWordEnd=>_currentWordEnd;

  void initTextToSpeech() {
     flutterTts.setVolume(1.0);
     flutterTts.setPitch(1.0);

    _flutterTts.setProgressHandler((text, start, end, word) {
        _currentWordStart = start;
        _currentWordEnd = end;
        notifyListeners();
    });
    _flutterTts.getVoices.then((data) {
      try {
        List<Map> voices = List<Map>.from(data);
          _voices =
              voices.where((voice) => voice["name"].contains("en")).toList();
          _currentVoice = _voices.first;
          setVoice(_currentVoice!);
          notifyListeners();
      } catch (e) {
        print(e);
      }
    });
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }


  setGridSizedModel(GridSizeModel grid){
    _gridSizedModel=grid;
    notifyListeners();
  }

  Future<void>getCurrentSelectedGridSizedModel( ContentProvider contentProvider) async{
    await contentProvider.getAllGridSizeModel();
    _gridSizedModel =  contentProvider.allGridSizedModel.firstWhere((grid) => grid.currentSelected==true,orElse:()=> contentProvider.allGridSizedModel[0]);


    notifyListeners();

  }

  makeDuplicateGridSizedModel(GridSizeModel gridSizedModel){
    _duplicateGridSizedModel=gridSizedModel;
    notifyListeners();


  }

  wordsOnlyShowSettings(int index){
    _settingsWordOnlyShow=index;
    notifyListeners();
  }

  useSpeechFunction(){
    _useSpeech=!_useSpeech;
    notifyListeners();
  }


  setHideButton(){
    _gridSizedModel.setHide();
    notifyListeners();
  }

  showAllButton(){
    _gridSizedModel.showHide();
    notifyListeners();
  }






  String _imagePath="";
  String get imagePath=>_imagePath;

   void addVideoToList(String videoPath){
     _videos.add(videoPath);
     notifyListeners();
   }

  void removeVideosFromList(int index){
    _videos.removeAt(index);
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
      _isEditPressed=false;
      AppUtility.popOver(context,EditPopOver(title: title, picture: picture),

          direct: PopoverDirection.top  ,heightSize: context.height*1.2,widthSize: context.width*0.9);


    }

    notifyListeners();
  }


  void isEditPressedFun() {
     _isEditPressed=!_isEditPressed;
    notifyListeners();
  }







}