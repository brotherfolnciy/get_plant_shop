import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/Bloc.dart';

class AuthenticationBloc extends Bloc {
  AuthenticationBloc({required this.repository}) : super(repository);

  final Repository repository;

  @override
  void dispose() {
    super.dispose();
  }
}
