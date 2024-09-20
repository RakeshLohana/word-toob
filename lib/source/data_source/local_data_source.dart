import 'package:word_toob/source/core/client_local.dart';
import 'package:word_toob/source/models/grid_size_model.dart';

abstract class ILocalDataSource{

  final LocalClient localClient;

  const ILocalDataSource({required this.localClient});


  Future<List<GridSizeModel>> getAllGridSizedModel();
  Future<void> saveAllGridSizedModel({required List<GridSizeModel> gridSizedModelList});
  Future<void> saveGridSizedModel({required GridSizeModel gridSizedModel});



}


class LocalDataSource extends ILocalDataSource{

  const LocalDataSource({required super.localClient});

  @override
  Future<List<GridSizeModel>> getAllGridSizedModel() async {
    final response = await localClient.getAllGridSizedModel();
    return response;
  }

  @override
  Future<void> saveAllGridSizedModel({required List<GridSizeModel> gridSizedModelList}) async {
    final response = await localClient.saveAllGridSizedModel(gridSizedModelList: gridSizedModelList);
    return response;
  }


  @override
  Future<void> saveGridSizedModel({required GridSizeModel gridSizedModel}) async {
    final response = await localClient.saveGridSizedModel(gridSizedModel: gridSizedModel);
    return response;
  }



}