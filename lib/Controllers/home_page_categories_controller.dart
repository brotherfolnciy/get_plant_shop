import 'package:flutter/material.dart';

class HomePageCategoriesController extends ChangeNotifier {
  String selectedCategoriesName = 'Concept';

  void setValue(String value) {
    this.selectedCategoriesName = value;
    notifyListeners();
  }
}
