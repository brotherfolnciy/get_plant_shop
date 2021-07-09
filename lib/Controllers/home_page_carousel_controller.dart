import 'package:flutter/material.dart';

class HomePageCarouselController extends ChangeNotifier {
  int selectedItemIndex = 0;

  void setValue(int value) {
    this.selectedItemIndex = value;
    notifyListeners();
  }
}
