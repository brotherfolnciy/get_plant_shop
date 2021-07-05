import 'package:plant_shop/models/filter.dart';
import 'package:plant_shop/models/plant.dart';

class Repository {
  late List<Plant> plants;
  late List<String> categories;
  late PlantFilter currentPlantFilter;

  Repository() {
    initializeRepository();
  }

  initializeRepository() {
    plants = [
      Plant(
          1,
          "Роза",
          54,
          11,
          144,
          "",
          "Красивое растение для жены",
          ["popular", "new", "concept"],
          ClimateType.Sunny,
          PlacementType.Garden),
      Plant(
          2,
          "Ромашка",
          24,
          46,
          56,
          "",
          "Красивое растение с белыми лепестками",
          ["concept"],
          ClimateType.Sunny,
          PlacementType.Garden),
      Plant(3, "Василек", 65, 35, 87, "", "Красивое растение для дома",
          ["popular", "concept"], ClimateType.Wet, PlacementType.Outdoor),
      Plant(4, "Тюльпан", 87, 78, 178, "", "Красивое растение для подарка",
          ["popular", "concept"], ClimateType.Sunny, PlacementType.Garden),
      Plant(
          5,
          "Одуванчик",
          98,
          45,
          50,
          "",
          "Красивое растение похожее на парашют",
          ["new", "concept"],
          ClimateType.Cold,
          PlacementType.Outdoor),
    ];
    categories = ["Concept", "Popular", "New"];
    currentPlantFilter =
        PlantFilter("", 1, 100, PlacementType.Garden, ClimateType.Sunny);
  }

  Plant getPlantById(int id) {
    return plants.where((element) => element.id == id).toList().first;
  }

  int get plantsCount => plants.length;
}
