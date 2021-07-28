import 'package:plant_shop/models/plant.dart';

class PlantPurchase {
  final String id;
  final Plant plant;
  final String potName;
  late int count;

  PlantPurchase(this.id, this.plant, this.count, this.potName);

  int get totalPrice => plant.price * count;
}

class PlantPurchaseRequest {
  final int plantId;
  final String potName;
  final int count;

  PlantPurchaseRequest(this.plantId, this.count, this.potName);
}
