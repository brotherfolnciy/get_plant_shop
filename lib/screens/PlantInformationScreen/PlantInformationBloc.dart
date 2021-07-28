import 'package:plant_shop/models/plant_purchase.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/Bloc.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_pot_selector.dart';

class PlantInformationBloc extends Bloc {
  PlantInformationBloc({required this.repository}) : super(repository);

  final Repository repository;

  void initializeBloc() {}

  void addPlantPurchase(String plantName, int count, PotData potData) {
    repository.addPurchasePlant(
      PlantPurchaseRequest(
          repository.plants
              .singleWhere((element) => element.name == plantName)
              .id,
          count,
          potData.potName),
    );
  }

  @override
  void dispose() {}
}
