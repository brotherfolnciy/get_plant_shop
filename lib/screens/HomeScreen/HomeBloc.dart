import 'dart:async';

import 'package:plant_shop/models/filter.dart';
import 'package:plant_shop/models/plant.dart';
import 'package:plant_shop/models/plant_purchase.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/Bloc.dart';
import 'package:plant_shop/screens/HomeScreen/HomeBlocScreen.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBlocScreen.dart';
import 'package:plant_shop/widgets/HomePage/home_page_carousel_item.dart';

class HomeBloc extends Bloc {
  HomeBloc({required this.repository}) : super(repository);

  final Repository repository;

  late String _selectedCategory;
  late PlantFilter _currentPlantFilter;

  late PlantInformationBloc plantInformationBloc;

  late bool isInitialize = false;
  void initializeBloc() {
    if (isInitialize) return;
    _selectedCategory = 'Concept';
    _currentPlantFilter = PlantFilterController.emptyPlantFilter;
    setViewPlantsDataList();
    setCategoriesList(getCategoriesFromRepository());
    isInitialize = true;
  }

  //
  final _viewPlantsDataListController =
      StreamController<List<PlantItemData>>.broadcast();

  final _categoriesListStreamController =
      StreamController<List<String>>.broadcast();

  //
  Stream<List<PlantItemData>> get plantsList =>
      _viewPlantsDataListController.stream;

  Stream<List<String>> get categoriesList =>
      _categoriesListStreamController.stream;

  //
  void setViewPlantsDataList() {
    _viewPlantsDataListController.sink.add(getPlantsDataFromRepository());
  }

  void setCategoriesList(List<String> _categoriesList) {
    _categoriesListStreamController.sink.add(_categoriesList);
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    setViewPlantsDataList();
  }

  void setCurrentFilter(FilterData filterData) {
    late PlacementType placementType;
    late ClimateType climateType;

    switch (filterData.filterClimateTypeName) {
      case "Wet":
        climateType = ClimateType.Wet;
        break;
      case "Sunny":
        climateType = ClimateType.Sunny;
        break;
      case "Cold":
        climateType = ClimateType.Cold;
        break;
      default:
        climateType = ClimateType.None;
        break;
    }

    switch (filterData.filterPlacementTypeName) {
      case "Indoor":
        placementType = PlacementType.Indoor;
        break;
      case "Outdoor":
        placementType = PlacementType.Outdoor;
        break;
      case "Garden":
        placementType = PlacementType.Garden;
        break;
      default:
        placementType = PlacementType.None;
        break;
    }

    PlantFilter plantFilter = PlantFilter(
      filterData.filterName,
      filterData.filterPriceMin,
      filterData.filterPriceMax,
      placementType,
      climateType,
    );

    _currentPlantFilter = plantFilter;
  }

  void addPlantPurchase(int plantId) {
    repository.addPurchasePlant(
      PlantPurchaseRequest(plantId, 1, "1"),
    );
  }

  PlantInformationData getPlantInformationDataFromPlantId(int plantId) {
    Plant plant =
        repository.plants.singleWhere((element) => element.id == plantId);

    PlantInformationData plantInformationData = PlantInformationData(
        plant.name, plant.price, plant.description, plant.imageUrl);

    return plantInformationData;
  }

  //
  List<PlantItemData> getPlantsDataFromRepository() {
    List<PlantItemData> _plantsDataList = [];

    List<Plant> plantsFromRepository = repository.plants
        .where((element) =>
            element.tags.contains(_selectedCategory.toLowerCase()) &&
            _currentPlantFilter.checkPlantByFilter(element))
        .toList();

    for (int i = 0; i < plantsFromRepository.length; i++) {
      Plant plant = plantsFromRepository[i];
      PlantItemData plantItemData = PlantItemData(
          plant.id,
          plant.name,
          "W ${plant.width} ??? H ${plant.height} MM",
          plant.price,
          plant.imageUrl);
      _plantsDataList.add(plantItemData);
    }

    return _plantsDataList;
  }

  List<String> getCategoriesFromRepository() {
    return repository.categories;
  }

  @override
  void dispose() {
    _viewPlantsDataListController.close();
    _categoriesListStreamController.close();
  }
}
