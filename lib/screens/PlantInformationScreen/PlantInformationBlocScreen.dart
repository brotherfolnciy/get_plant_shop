import 'package:flutter/material.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:provider/provider.dart';

class PlantInformationScreen extends StatefulWidget {
  PlantInformationScreen({Key? key}) : super(key: key);

  @override
  _PlantInformationScreenState createState() => _PlantInformationScreenState();
}

class _PlantInformationScreenState extends State<PlantInformationScreen> {
  late PlantInformationBloc plantInformationBloc;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantInformationBloc>(
      builder: (context, plantInformationBloc, child) {
        this.plantInformationBloc = plantInformationBloc;
        plantInformationBloc.initializeBloc();
        return Scaffold(
          body: getBody(),
        );
      },
    );
  }

  SafeArea getBody() {
    return SafeArea(
      child: Stack(
        children: [],
      ),
    );
  }
}
