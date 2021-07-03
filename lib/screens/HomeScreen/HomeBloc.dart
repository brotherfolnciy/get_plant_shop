import 'dart:async';

import 'package:plant_shop/models/repository.dart';

class HomeBloc {
  HomeBloc(this._repository);

  final Repository _repository;

  final _caruselSelectedItemStreamController =
      StreamController<int>.broadcast();

  final _selectedCategoryStreamController = StreamController<int>.broadcast();

  Stream<int> get caruselSelectedItem =>
      _caruselSelectedItemStreamController.stream;

  Stream<int> get selectedCategory => _selectedCategoryStreamController.stream;

  void setCaruselSelectedItem(int index) {
    _caruselSelectedItemStreamController.sink.add(index);
  }

  void setSelectedCategory(int category) {
    _selectedCategoryStreamController.sink.add(category);
  }

  void dispose() {
    _caruselSelectedItemStreamController.close();
    _selectedCategoryStreamController.close();
  }
}
