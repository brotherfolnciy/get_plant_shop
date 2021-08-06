import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plant_shop/controllers/services/auth.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/models/user.dart';
import 'package:plant_shop/screens/Bloc.dart';

enum AuthenticationBlocStates {
  offline,
  signOut,
  register,
  enter,
}

class AuthenticationBloc extends Bloc {
  AuthenticationBloc({required this.repository}) : super(repository);

  final Repository repository;
  final AuthService authService = AuthService();

  void initialize() {
    setCurrentState(AuthenticationBlocStates.offline);
    checkInternetConnection();
  }

  final _currentAuthenticationBlocState =
      StreamController<AuthenticationBlocStates>.broadcast();

  Stream<AuthenticationBlocStates> get currentState =>
      _currentAuthenticationBlocState.stream;

  void setCurrentState(AuthenticationBlocStates state) {
    _currentAuthenticationBlocState.sink.add(state);
  }

  void checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;

    print(result);

    if (result) {
      setCurrentState(AuthenticationBlocStates.signOut);
    } else {
      setCurrentState(AuthenticationBlocStates.offline);
    }
  }

  void signInWithEmailAndPassword(String email, String password) async {
    UserData? userData =
        await authService.signInWithEmailAndPassword(email, password);
    print(userData!.id);
  }

  void registeredWithEmailAndPassword(String email, String password) async {
    print('reg');
    UserData? userData =
        await authService.registeredWithEmailAndPassword(email, password);
    print(userData!.id);
  }

  @override
  void dispose() {
    super.dispose();
    _currentAuthenticationBlocState.close();
  }
}
