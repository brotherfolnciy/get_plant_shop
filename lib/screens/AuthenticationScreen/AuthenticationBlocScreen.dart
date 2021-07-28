import 'package:flutter/material.dart';
import 'package:plant_shop/screens/AuthenticationScreen/AuthenticationBloc.dart';
import 'package:provider/provider.dart';

class AuthentificationScreen extends StatefulWidget {
  AuthentificationScreen({Key? key}) : super(key: key);

  @override
  _AuthentificationScreenState createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {
  late AuthenticationBloc authentificationBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Consumer<AuthenticationBloc>(
        builder: (context, authentificationBloc, child) {
      this.authentificationBloc = authentificationBloc;
      return Container();
    });
  }
}
