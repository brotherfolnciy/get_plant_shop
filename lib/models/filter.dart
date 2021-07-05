import 'package:plant_shop/models/plant.dart';

class PlantFilter {
  final String filterName;
  final int filterPriceMin;
  final int filterPriceMax;
  final PlacementType filterPlacementType;
  final ClimateType filterClimateType;

  PlantFilter(
    this.filterName,
    this.filterPriceMin,
    this.filterPriceMax,
    this.filterPlacementType,
    this.filterClimateType,
  );

  bool checkPlantByFilter(Plant plant) {
    if (plant.name.contains(filterName) && filterName.isEmpty) {
      if (plant.price > filterPriceMin && plant.price < filterPriceMax) {
        if (plant.placementType == filterPlacementType) {
          if (plant.climateType == filterClimateType) {
            return true;
          } else {
            return false;
          }
        } else
          return false;
      } else
        return false;
    } else
      return false;
  }
}
