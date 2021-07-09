import 'dart:async';

import 'package:plant_shop/models/plant.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBlocScreen.dart';

class PlantInformationBloc {
  PlantInformationBloc({required this.repository});

  final Repository repository;

  void initializeBloc() {}

  void dispose() {}
}
