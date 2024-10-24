import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:popover/popover.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:word_toob/app_providers/content_provider.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/common/utils/app_utility.dart';
import 'package:word_toob/source/models/grid_model.dart';
import 'package:word_toob/source/models/grid_size_model.dart';
import 'package:word_toob/views/theme/app_color.dart';
import 'package:word_toob/views/widgets/custom_bottom_sheet.dart';
import 'package:word_toob/views/widgets/edit_pop_over.dart';

import '../common/app_constants/route_strings.dart';

class MainDashboardController extends ChangeNotifier{



  int _gridSizeX=1;

  BuildContext? _contextForSpeechToText;

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

  int _gridIndex=0 ;
  int get gridIndex  => _gridIndex;


  bool _useSpeech=true ;
  bool get useSpeech  => _useSpeech;


  bool _findWordImage=false ;
  bool get findWordImage  => _findWordImage;


  bool _lottie=false ;
  bool get lottie  => _lottie;

  bool _findTheWord =false;
  bool get findTheWord=>_findTheWord;

  bool _freePlay =false;
  bool get freePlay=>_freePlay;



  bool _foundSuccess =false;
  bool get foundSuccess=>_foundSuccess;

  String _targetFindWord ="";
  String get targetFindWord=>_targetFindWord;

  String _findWordImagePath ="";
  String get findWordImagePath=>_findWordImagePath;

  int _randomListIndex =0;
  int get randomListIndex=>_randomListIndex;


  List<String> _videos=[];
  List<String> get videos=>_videos;


  List<GridModel> _gridItemMain=[];
  List<GridModel> get gridItemMain=>_gridItemMain;



  GridSizeModel _gridSizedModel=GridSizeModel();
  GridSizeModel get gridSizedModel=>_gridSizedModel;



  GridSizeModel _duplicateGridSizedModel=GridSizeModel();
  GridSizeModel get duplicateGridSizedModel=>_duplicateGridSizedModel;

  List<int> _findTheWordWrongList=[];
  List<int> get findTheWordWrongList=>_findTheWordWrongList;


  bool _speechToTextCheck =false;
  bool get speechToTextCheck=>_speechToTextCheck;

  void setSpeechToText(BuildContext context){
    _speechToTextCheck=!_speechToTextCheck;
    if(_speechToTextCheck){
      startListening(context);
    }
    else{
      stopListening();
    }
    notifyListeners();


  }


  ///Speech to text
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  void initSpeechToText() async {
    speechEnabled = await speechToText.initialize();
    notifyListeners();

  }


  void startListening(BuildContext context) async {
    await speechToText.listen(onResult: onSpeechResult);
    _contextForSpeechToText=context;
    notifyListeners();
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  ///

  void stopListening() async {
    await speechToText.stop();
  }


  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    debugPrint(lastWords);
    int index = gridSizedModel.listData?.indexWhere((gridModel) => gridModel.title == lastWords) ?? -1;


    if (index != -1) {
      debugPrint("Match found at index: $index");
      GridModel matchedModel = gridSizedModel.listData?[index]??GridModel();
      var rand=Random().nextInt(matchedModel.videosPath?.length??0+1);

      Navigator.pushNamed(_contextForSpeechToText!, RouteStrings.videoPlayer,arguments: matchedModel.videosPath?[rand]);

    } else {
      debugPrint("No match found for: $lastWords");
    }
  }




  ///Text to speech
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


  setGridSizedModel(GridSizeModel grid,int index){
    _gridSizedModel=grid;
    _gridIndex=index;
    notifyListeners();
  }

  setLottie(){
    _lottie=true;
    printLog(_currentWordStart);
    Future.delayed(Duration(seconds: 2),(){
      _lottie=false;
      notifyListeners();


    });

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


  Future<void> setHideButton(ContentProvider contentProvider) async {
    printLog("grid index " + _gridIndex.toString());

    // Check if gridSizedModel has an ID
    if (_gridSizedModel.id != null) {
      // Await the update operation to ensure it completes before proceeding
      await contentProvider.updateGridSizeModelData(
        id: _gridSizedModel.id!,
        hideModel: true,
      );

      // After updating, fetch the updated model and reassign _gridSizedModel
      _gridSizedModel = GridSizeModel();  // Resetting the model
      GridSizeModel gridModel = contentProvider.allGridSizedModel
          .firstWhere((element) => element.id == 1);

      printLog(gridModel.toJson());

      // Update the local _gridSizedModel with the new data
      _gridSizedModel = contentProvider.allGridSizedModel[_gridIndex];
    }

    // Notify listeners about the update
    notifyListeners();
  }

  Future<void> showAllButton(ContentProvider contentProvider) async {
    printLog("grid index " + _gridIndex.toString());

    // Check if gridSizedModel has an ID
    if (_gridSizedModel.id != null) {
      // Await the update operation to ensure it completes before proceeding
      await contentProvider.updateGridSizeModelData(
        id: _gridSizedModel.id!,
        hideModel: false, // Show the model
      );

      // After updating, fetch the updated model and reassign _gridSizedModel
      _gridSizedModel = GridSizeModel();  // Resetting the model
      GridSizeModel gridModel = contentProvider.allGridSizedModel
          .firstWhere((element) => element.id == 1);

      printLog(gridModel.toJson());

      // Update the local _gridSizedModel with the new data
      _gridSizedModel = contentProvider.allGridSizedModel[_gridIndex];
    }

    // Notify listeners about the update
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



  void setItemOnEditState(int index,BuildContext context,{required String title,required String picture,required int id,
    required bool hide,
    required List<String> videoPath,
    required int gridIndex }) {

    if (_editPressed) {
      _itemClickedOnEditState = index;
      _itemClickeBool = true;
      _showBottomSheetVideo=false;
      _showBottomSheet=false;
      _isEditPressed=false;
      _imagePath='';
      AppUtility.popOver(context,EditPopOver(title: title, picture: picture,index: index,id: id,gridIndex:gridIndex ,hide:hide ,),

          direct: PopoverDirection.top  ,heightSize: context.height*1.2,widthSize: context.width*0.9);
      _videos.clear();
      _videos.addAll(videoPath);
      notifyListeners();


    }

    notifyListeners();
  }


  void isEditPressedFun() {
     _isEditPressed=!_isEditPressed;
    notifyListeners();
  }


  void setFindTheWord(bool value) {
     _findTheWord=value;

    notifyListeners();
  }




  void setRandomIndex() {
    _randomListIndex=Random().nextInt(gridSizedModel.listData!.length-1);
    _targetFindWord=gridSizedModel.listData?[_randomListIndex].title??"";
    flutterTts.speak( "Find ${_targetFindWord}");

    notifyListeners();
  }

  void setCurrentIndex() {
    _targetFindWord=gridSizedModel.listData?[_randomListIndex].title??"";
    flutterTts.speak( "Find ${_targetFindWord}");

    notifyListeners();
  }


  void setFindTheWordWrongList(int index){
    _findTheWordWrongList.add(index);
    notifyListeners();
  }

  void clearFindTheWrongList(){
     _findTheWordWrongList.clear();
    notifyListeners();
  }

  void setFindWordImage(bool value){
    _findWordImage=value;
    notifyListeners();
  }

  void setFindWordImagePath(String path){
    _findWordImagePath=path;
    notifyListeners();
  }


  void setFoundSuccess(bool value){
    _foundSuccess=value;
    notifyListeners();
  }


  void setFreePlayOn(bool value) {
    _freePlay=value;

    notifyListeners();
  }
}