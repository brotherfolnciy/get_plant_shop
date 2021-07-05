import 'dart:async';

import 'package:plant_shop/models/filter.dart';
import 'package:plant_shop/models/plant.dart';
import 'package:plant_shop/models/repository.dart';

class HomeBloc {
  HomeBloc(this._repository) {
    plants = _repository.plants;
    categories = _repository.categories;
    filterPanelIsOpen = false;
    currentPlantFilter = _repository.currentPlantFilter;
    setPlantFilter(_repository.currentPlantFilter);
    setSelectedCategory(_repository.categories[0]);
    setCaruselItemsCount(plants.length);
    setCaruselSelectedItem(0);
    setFilterPanelOpenStatus(false);
  }

  final Repository _repository;

  late List<Plant> plants;
  late List<String> categories;
  late PlantFilter currentPlantFilter;
  late bool filterPanelIsOpen;

  //
  final _caruselItemsCountStreamController = StreamController<int>.broadcast();

  final _caruselSelectedItemStreamController =
      StreamController<int>.broadcast();

  final _selectedCategoryStreamController =
      StreamController<String>.broadcast();

  final _plantFilterStreamController =
      StreamController<PlantFilter>.broadcast();

  final _filterPanelOpenStatusStreamController =
      StreamController<bool>.broadcast();

  //
  Stream<int> get caruselItemsCount =>
      _caruselItemsCountStreamController.stream;

  Stream<int> get caruselSelectedItem =>
      _caruselSelectedItemStreamController.stream;

  Stream<String> get selectedCategory =>
      _selectedCategoryStreamController.stream;

  Stream<PlantFilter> get plantFilter => _plantFilterStreamController.stream;

  Stream<bool> get filterPanelOpenStatus =>
      _filterPanelOpenStatusStreamController.stream;

  //
  void setCaruselItemsCount(int count) {
    _caruselItemsCountStreamController.sink.add(count);
  }

  void setCaruselSelectedItem(int index) {
    _caruselSelectedItemStreamController.sink.add(index);
  }

  void setSelectedCategory(String categoryName) {
    _selectedCategoryStreamController.sink.add(categoryName);
  }

  void setPlantFilter(PlantFilter plantFilter) {
    _plantFilterStreamController.sink.add(plantFilter);
  }

  void setFilterPanelOpenStatus(bool flag) {
    _filterPanelOpenStatusStreamController.sink.add(flag);
  }

  //
  void dispose() {
    _caruselItemsCountStreamController.close();
    _caruselSelectedItemStreamController.close();
    _selectedCategoryStreamController.close();
    _plantFilterStreamController.close();
    _filterPanelOpenStatusStreamController.close();
  }
}
