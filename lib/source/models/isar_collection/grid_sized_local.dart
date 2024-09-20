import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:word_toob/source/models/grid_model.dart';
import 'package:word_toob/source/models/isar_collection/grid_local.dart';

part 'grid_sized_local.g.dart';

@collection
class GridSizedLocal{
  Id id = Isar.autoIncrement;
  int? gridSizeX;
  int? gridSizeY;
  String? title;
  bool? hideModel;
  int duplicateCount=1;
  List<String>? listDataJson;
  bool currentSelected=false;


  // Method to serialize listData
  List<String>? setListData(List<GridModel> data) {
    listDataJson = data.map((e) => jsonEncode(e.toJson())).toList();
    return listDataJson;
  }

  // Method to deserialize listData
  List<GridModel>? getListData(List<String>? listDataJson) {
    return listDataJson?.map((e) => GridModel.fromJson(jsonDecode(e))).toList();
  }}
