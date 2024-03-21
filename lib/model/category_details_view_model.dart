import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/sourceResponse.dart';

class CategoryDetailsViewModel extends ChangeNotifier {
  // todo: hold data
  List<Source>? sourceList;
  String? errorMessage;

//   todo: handle logic

  Future<void> getResponse(String categoryId) async {
    sourceList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getResponse(categoryId);
      if (response?.status == "error") {
        errorMessage = response!.message;
      } else {
        sourceList = response!.sources;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
