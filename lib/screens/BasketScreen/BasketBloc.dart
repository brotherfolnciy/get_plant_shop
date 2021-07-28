import 'dart:async';

import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/Bloc.dart';
import 'package:plant_shop/widgets/BasketPage/basket_page_plant_purchases_list_item.dart';

class BasketBloc extends Bloc {
  BasketBloc({required this.repository}) : super(repository);

  final Repository repository;

  late List<PlantPurchaseItemData> viewPlantPurchasesItemData;

  late bool isInitialize = false;
  void initializeBloc() {
    if (isInitialize) return;
    refreshViewPlantPurchasesDataList();
    isInitialize = true;
  }

  final _viewPlantPurchasesDataListController =
      StreamController<List<PlantPurchaseItemData>>.broadcast();

  Stream<List<PlantPurchaseItemData>> get plantPurchasesDataList =>
      _viewPlantPurchasesDataListController.stream;

  void refreshViewPlantPurchasesDataList() {
    setViewPlantPurchasesDataList();
  }

  void setViewPlantPurchasesDataList() {
    viewPlantPurchasesItemData = getPlantPurchasesDataFromRepository();
    _viewPlantPurchasesDataListController.sink.add(viewPlantPurchasesItemData);
  }

  List<PlantPurchaseItemData> getPlantPurchasesDataFromRepository() {
    List<PlantPurchaseItemData> plantPurchasesItemData = [];

    repository.purchasedPlants.forEach((element) {
      plantPurchasesItemData.add(PlantPurchaseItemData(
        element.id,
        element.plant.name,
        element.plant.imageUrl,
        repository.baskets
            .singleWhere((basket) => basket.name == element.potName)
            .imagePath,
        "W ${element.plant.width} ⨯ H ${element.plant.height} MM",
        element.count,
        element.plant.price,
      ));
    });

    return plantPurchasesItemData;
  }

  void removePlantPurchaseById(String id) {
    repository.removePurchasePlantById(id);
    _viewPlantPurchasesDataListController.sink
        .add(getPlantPurchasesDataFromRepository());
  }

  void sendPurchasesPlants() {
    repository.sendPurchasesPlants();
  }

  @override
  void dispose() {
    _viewPlantPurchasesDataListController.close();
  }
}
