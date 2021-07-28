import 'package:plant_shop/models/repository.dart';

class Bloc {
  Bloc(this.repository);

  final Repository repository;

  void dispose() {}
}
