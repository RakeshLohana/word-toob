import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/source/data_source/local_data_source.dart';
import 'package:word_toob/source/models/grid_size_model.dart';

abstract class IAppRepository{

  final ILocalDataSource localDataSource;
  const IAppRepository({ required this.localDataSource});

  Future<List<GridSizeModel>> getAllGridSizedModel();
  Future<void> saveAllGridSizedModel({required List<GridSizeModel> gridSizedModelList});
  Future<void> saveGridSizedModel({required GridSizeModel gridSizedModel});

}


class AppRepository extends IAppRepository{


  AppRepository({required super.localDataSource});


  @override
  Future<List<GridSizeModel>> getAllGridSizedModel() async {
    try {
      final response = await localDataSource.getAllGridSizedModel();
      return response;
    } catch(e){
      printLog(e.toString());
      return [];
    }
  }

  @override
  Future<void> saveAllGridSizedModel({required List<GridSizeModel> gridSizedModelList}) async {
    try {
       await localDataSource.saveAllGridSizedModel(gridSizedModelList: gridSizedModelList);
    } catch(e){
      printLog(e.toString());
    }
  }

  @override
  Future<void> saveGridSizedModel({required GridSizeModel gridSizedModel}) async{
    try {
      await localDataSource.saveGridSizedModel(gridSizedModel: gridSizedModel);
    } catch(e){
      printLog(e.toString());

    }
  }




}