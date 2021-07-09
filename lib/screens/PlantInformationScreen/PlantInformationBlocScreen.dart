import 'package:flutter/material.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:provider/provider.dart';

class PlantInformationData {
  final String plantName;
  final int plantPrice;
  final String plantdescription;

  PlantInformationData(this.plantName, this.plantPrice, this.plantdescription);
}

class PlantInformationScreen extends StatefulWidget {
  PlantInformationScreen({Key? key, required this.plantInformationData})
      : super(key: key);

  final PlantInformationData plantInformationData;

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
      child: Column(
        children: [
          Text('${widget.plantInformationData.plantName}'),
          Text('${widget.plantInformationData.plantPrice}'),
          Text('${widget.plantInformationData.plantdescription}'),
        ],
      ),
    );
  }
}
