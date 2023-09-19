import 'package:flutter/foundation.dart';

void printLog(data) {
  if (kDebugMode) {
    print("==============================================="
        "$data"
        "===============================================");
  }
}
