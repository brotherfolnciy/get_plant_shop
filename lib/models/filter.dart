import 'package:plant_shop/models/plant.dart';

class PlantFilterController {
  static PlantFilter get emptyPlantFilter =>
      PlantFilter("", 0.0, 799.0, PlacementType.None, ClimateType.None);
}

class PlantFilter {
  String filterName;
  double filterPriceMin;
  double filterPriceMax;
  PlacementType filterPlacementType;
  ClimateType filterClimateType;

  PlantFilter(
    this.filterName,
    this.filterPriceMin,
    this.filterPriceMax,
    this.filterPlacementType,
    this.filterClimateType,
  );

  bool checkPlantByFilter(Plant plant) {
    if (plant.name.toLowerCase().contains(filterName) || filterName.isEmpty) {
      if (plant.price > filterPriceMin && plant.price < filterPriceMax) {
        if (plant.placementType == filterPlacementType ||
            filterPlacementType == PlacementType.None) {
          if (plant.climateType == filterClimateType ||
              filterClimateType == ClimateType.None) {
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
