
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:word_toob/common/app_constants/app_strings.dart';



/// Logging config
const kLOG_TAG = "[${AppString.appName}]";
const kLOG_ENABLE = kDebugMode;

void printLog(dynamic data) {
  if (kLOG_ENABLE) {
    log("$kLOG_TAG ${data.toString()}");
  }
}