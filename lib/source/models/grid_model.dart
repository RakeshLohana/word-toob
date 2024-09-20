import 'dart:typed_data';

import 'package:isar/isar.dart';

@embedded
class GridModel {
  String? _title;
  String? _imagepath;
  List<String>? _videosPath;
  bool? _hideImage;
  bool? _hidetitle;

  GridModel({
    String? title,
    String? imagepath,
    List<String>? videosPath,
    bool? hideImage,
    bool? hidetitle,
  })  : _title = title,
        _imagepath = imagepath,
        _videosPath = videosPath,
        _hideImage = hideImage,
        _hidetitle = hidetitle;

  // Getters
  String? get title => _title;
  String? get imagepath => _imagepath;
  List<String>? get videosPath => _videosPath;
  bool? get hideImage => _hideImage;
  bool? get hidetitle => _hidetitle;

  // Setters
  set title(String? value) {
    _title = value;
  }

  set imagepath(String? value) {
    _imagepath = value;
  }

  set videosPath(List<String>? value) {
    _videosPath = value;
  }

  set hideImage(bool? value) {
    _hideImage = value;
  }

  set hidetitle(bool? value) {
    _hidetitle = value;
  }

  // fromJson method
  factory GridModel.fromJson(Map<String, dynamic> json) {
    return GridModel(
      title: json['title'],
      imagepath: json['imagepath'],
      videosPath: json['videosPath'] != null ? List<String>.from(json['videosPath']) : null,
      hideImage: json['hideImage'],
      hidetitle: json['hidetitle'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'imagepath': _imagepath,
      'videosPath': _videosPath,
      'hideImage': _hideImage,
      'hidetitle': _hidetitle,
    };
  }



}
