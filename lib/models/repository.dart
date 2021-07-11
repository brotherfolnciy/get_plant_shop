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
          "Rose",
          54,
          11,
          144,
          "http://cdn.shopify.com/s/files/1/0068/5614/7055/products/red-rosepot_2048x2048_657df2b8-7e08-4253-b8a2-3c73ea4f6638_2048x2048.png?v=1555341812.png",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget,Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget,Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget,Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["popular", "new", "concept"],
          ClimateType.Sunny,
          PlacementType.Garden),
      Plant(
          2,
          "Chamomile",
          24,
          46,
          56,
          "http://funforkids.ru/pictures/romashki/romashki52.png",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["concept"],
          ClimateType.Sunny,
          PlacementType.Garden),
      Plant(
          3,
          "Cornflower",
          65,
          35,
          87,
          "http://cdn0.woolworths.media/content/content/barry-2021-real-cornflower.png",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["popular", "concept"],
          ClimateType.Wet,
          PlacementType.Outdoor),
      Plant(
          4,
          "Tulip",
          87,
          78,
          178,
          "",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["popular", "concept"],
          ClimateType.Sunny,
          PlacementType.Garden),
      Plant(
          5,
          "Одуванчик",
          98,
          45,
          50,
          "http://cdn.shopify.com/s/files/1/0068/5614/7055/products/red-rosepot_2048x2048_657df2b8-7e08-4253-b8a2-3c73ea4f6638_2048x2048.png?v=1555341812.png",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["new", "concept"],
          ClimateType.Cold,
          PlacementType.Outdoor),
    ];
    categories = ["Concept", "Popular", "New"];
    currentPlantFilter = PlantFilterController.emptyPlantFilter;
  }

  Plant getPlantById(int id) {
    return plants.where((element) => element.id == id).toList().first;
  }

  int get plantsCount => plants.length;
}
