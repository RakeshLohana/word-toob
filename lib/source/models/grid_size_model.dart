import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/source/models/grid_model.dart';
import 'package:word_toob/source/models/isar_collection/grid_sized_local.dart';

class GridSizeModel{
   late int duplicateCount;
  int? gridSizeX;
  int? gridSizeY;
  String? title;
  bool? hideModel;
  List<GridModel>? listData;
  late bool currentSelected;


  GridSizeModel({
    this.gridSizeX,
    this.hideModel,
    this.gridSizeY,
    this.listData,
    this.title,
    this.duplicateCount=1,
    this.currentSelected=false,

});

  void setHide() {
    hideModel =  true;
  }

  void showHide() {
    hideModel =  false;
  }



  GridSizeModel.fromLocal(GridSizedLocal localDetails){
    try{
      gridSizeX = localDetails.gridSizeX;
      gridSizeY = localDetails.gridSizeY;
      listData = localDetails.getListData(localDetails.listDataJson);
      title = localDetails.title;
      hideModel = localDetails.hideModel;
      currentSelected=localDetails.currentSelected??false;
      duplicateCount=localDetails.duplicateCount??1;
    }catch(e){
      printLog("GridSizeModel.fromLocal: $e");
    }
  }


}

