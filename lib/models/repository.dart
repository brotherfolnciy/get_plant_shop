import 'package:plant_shop/models/pot.dart';
import 'package:plant_shop/models/filter.dart';
import 'package:plant_shop/models/plant.dart';
import 'package:plant_shop/models/plant_purchase.dart';
import 'package:uuid/uuid.dart';

class Repository {
  late List<Plant> plants;
  late List<String> categories;
  late List<Pot> baskets;
  late PlantFilter currentPlantFilter;

  late List<PlantPurchase> purchasedPlants;

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
          PlacementType.Outdoor),
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
          "Calathea Crocata",
          87,
          78,
          178,
          "https://cdn.webshopapp.com/shops/30495/files/308362457/calathea-crocata-pot-25-cm-10-flowers.jpg",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["popular", "concept"],
          ClimateType.Wet,
          PlacementType.Indoor),
      Plant(
          5,
          "Amaryllis",
          98,
          45,
          50,
          "https://www.pnglib.com/wp-content/uploads/2020/08/pink-and-white-amaryllis-in-flower-pot_5f3e5a40c6f9d.png",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
          ["new", "concept"],
          ClimateType.Cold,
          PlacementType.Indoor),
    ];
    categories = ["Concept", "Popular", "New"];
    baskets = [
      Pot('1', 'assets/images/pots/pot_1.png'),
      Pot('2', 'assets/images/pots/pot_2.png'),
      Pot('3', 'assets/images/pots/pot_3.png'),
    ];
    currentPlantFilter = PlantFilterController.emptyPlantFilter;
    purchasedPlants = [];
  }

  Plant getPlantById(int id) {
    return plants.where((element) => element.id == id).toList().first;
  }

  addPurchasePlant(PlantPurchaseRequest plantPurchaseRequest) {
    bool isMissed = true;

    PlantPurchase plantPurchase = PlantPurchase(
      Uuid().v1(),
      plants
          .singleWhere((element) => element.id == plantPurchaseRequest.plantId),
      plantPurchaseRequest.count,
      plantPurchaseRequest.potName,
    );

    purchasedPlants.forEach((element) {
      if (element.plant == plantPurchase.plant &&
          element.potName == plantPurchaseRequest.potName) {
        element.count += plantPurchaseRequest.count;
        isMissed = false;
      }
    });
    if (isMissed == true) purchasedPlants.add(plantPurchase);
  }

  removePurchasePlantById(String id) {
    purchasedPlants.removeWhere((element) => element.id == id);
  }

  sendPurchasesPlants() {
    int totalPrice = 0;

    print('');
    print('| User`s purchases');
    print('|');
    for (int i = 0; i < purchasedPlants.length; i++) {
      totalPrice += purchasedPlants[i].plant.price * purchasedPlants[i].count;
      print(
          '| ${i + 1} | User purchase ${purchasedPlants[i].plant} with ${purchasedPlants[i].potName} pot in count: ${purchasedPlants[i].count}');
    }
    print('|');
    print(
        '| Total plants count: ${purchasedPlants.length} | Total plant price: $totalPrice');
    print('');
  }

  int get plantsCount => plants.length;
}
