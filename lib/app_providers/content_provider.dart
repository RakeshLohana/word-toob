import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:word_toob/app_providers/app_setting_provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';
import 'package:word_toob/common/app_constants/assets.dart';
import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/source/models/grid_size_model.dart';
import 'package:word_toob/source/repository/app_repository.dart';

class ContentProvider extends ChangeNotifier{


  final IAppRepository iAppRepository;

  ContentProvider({required this.iAppRepository});



  List<GridSizeModel> _allGridSizedModel = [];
  List<GridSizeModel> get allGridSizedModel => _allGridSizedModel;


  Status getAllGridSizeModelStatus = Status.initial;
  Status saveAllGridSizeModelStatus = Status.initial;
  Status saveGridSizeModelStatus = Status.initial;


  List<Uint8List> imagesToBeLoaded= [];
  List<String> namesToBeLoaded= [];




  List<Map<String,dynamic>> _imagePathsPreLoad = [
    {"name":"Happy","image":MyAssets.happyP,},
    {"name":"Sad","image":MyAssets.sad,},
    {"name":"Mad","image":MyAssets.mad,},
    {"name":"Excited","image":MyAssets.excited},
    {"name":"Frustrated","image":MyAssets.frustrated,},
    {"name":"Scared","image":MyAssets.scared,},
    {"name":"Love","image":MyAssets.love},
    {"name":"Surprised","image":MyAssets.surprised},

  ];
  List<Map<String,dynamic>> get imagePathsPreLoad => _imagePathsPreLoad;




  Future getAllGridSizeModel() async {
    getAllGridSizeModelStatus = Status.loading;
    notifyListeners();
    try{
      _allGridSizedModel = await iAppRepository.getAllGridSizedModel();
      // log(_allGridSizedModel[0].listData.toString());
      notifyListeners();
      getAllGridSizeModelStatus = Status.loaded;
    }on Exception catch (e){
      getAllGridSizeModelStatus = Status.error;
      printLog(e.toString());
    }
    notifyListeners();
  }



  Future saveAllGridSizedModel({required List<GridSizeModel> gridSizedModelList,required ContentProvider contenProvider}) async {
    saveAllGridSizeModelStatus = Status.loading;
    notifyListeners();
    try{
      await getAllGridSizeModel();
       if(contenProvider.allGridSizedModel.isEmpty) await iAppRepository.saveAllGridSizedModel(gridSizedModelList: gridSizedModelList);
      await getAllGridSizeModel();
      notifyListeners();
      saveAllGridSizeModelStatus = Status.loaded;
    }on Exception catch (e){
      saveAllGridSizeModelStatus = Status.error;
      printLog(e.toString());
      // whenExceptionCatch(e);
    }
    notifyListeners();
  }



  Future saveGridSizedModel({required GridSizeModel gridSizedModel}) async {
    saveGridSizeModelStatus = Status.loading;
    notifyListeners();
    try{
      await getAllGridSizeModel();
      await iAppRepository.saveGridSizedModel(gridSizedModel: gridSizedModel);
       await getAllGridSizeModel();
    // GridSizeModel grid=   allGridSizedModel.firstWhere((grid) => grid.currentSelected==true,orElse:()=> allGridSizedModel[0]);
    // notifyListeners();
    //  mainDashBoard.setGridSizedModel(grid);
     notifyListeners();

       saveGridSizeModelStatus = Status.loaded;
    }on Exception catch (e){
      saveGridSizeModelStatus = Status.error;
      printLog(e.toString());
      // whenExceptionCatch(e);
    }
    notifyListeners();
  }


}