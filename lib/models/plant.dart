enum ClimateType { Wet, Sunny, Cold }
enum PlacementType { Indoor, Outdoor, Garden }

class Plant {
  final int id;
  final String name;
  final String description;
  final int price;
  final int width;
  final int height;
  final String imageUrl;
  final List<String> tags;
  final ClimateType climateType;
  final PlacementType placementType;

  Plant(this.id, this.name, this.price, this.width, this.height, this.imageUrl,
      this.description, this.tags, this.climateType, this.placementType);
}
