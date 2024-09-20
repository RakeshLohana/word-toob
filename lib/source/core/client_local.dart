import 'package:isar/isar.dart';
import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/source/models/grid_size_model.dart';
import 'package:word_toob/source/models/isar_collection/grid_sized_local.dart';

class LocalClient{

  final Isar isar;


  LocalClient({required this.isar,});


  Future<List<GridSizeModel>> getAllGridSizedModel() async {
    final response = await isar.txn(()async{
      List<GridSizedLocal> gridSizedLocalList = await isar.gridSizedLocals.where().findAll();
      List<GridSizeModel> gridSizedModalList= [];
      for(var item in gridSizedLocalList){
        gridSizedModalList.add(GridSizeModel.fromLocal(item));
      }
      return gridSizedModalList ;
    });
    printLog("Fetched local gridSizedModels");
    return response;
  }


  Future<void> saveAllGridSizedModel({required List<GridSizeModel> gridSizedModelList}) async {

    List<GridSizedLocal> gridSizedLocalAll = [];

    for(var item in gridSizedModelList){
      gridSizedLocalAll.add(
          GridSizedLocal()
            ..hideModel = item.hideModel

            ..title = item.title
             ..listDataJson=GridSizedLocal().setListData(item.listData??[])
              ..gridSizeY=item.gridSizeY
              ..gridSizeX=item.gridSizeX

      );
    }
    await isar.writeTxn(()async{
      await isar.gridSizedLocals.clear();
      await isar.gridSizedLocals.putAll(gridSizedLocalAll);
      printLog("Local GridSizedModel all List saved");
    });
  }



  Future<void> saveGridSizedModel({required GridSizeModel gridSizedModel}) async {




     GridSizedLocal gridSizedLocal=     GridSizedLocal()
            ..hideModel = gridSizedModel.hideModel

            ..title = gridSizedModel.title
             ..listDataJson=GridSizedLocal().setListData(gridSizedModel.listData??[])
             ..currentSelected=gridSizedModel.currentSelected
       ..duplicateCount=gridSizedModel.duplicateCount

              ..gridSizeY=gridSizedModel.gridSizeY
              ..gridSizeX=gridSizedModel.gridSizeX;


    await isar.writeTxn(()async{
      List<GridSizedLocal> gridSizedLocalList = await isar.gridSizedLocals.where().findAll();
      gridSizedLocalList.add(gridSizedLocal);
      await isar.gridSizedLocals.putAll(gridSizedLocalList);
      printLog("Local GridSizedModel saved ");
    });
  }

}