import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_counter.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_description_panel.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_description_text.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_favourites_button.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_information_panel.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_pot_selector.dart';
import 'package:plant_shop/widgets/expandable_text.dart';
import 'package:plant_shop/widgets/price_text.dart';
import 'package:provider/provider.dart';

class PlantInformationData {
  final String plantName;
  final int plantPrice;
  final String plantDescription;
  final String plantImageUrl;

  PlantInformationData(this.plantName, this.plantPrice, this.plantDescription,
      this.plantImageUrl);
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

  late ValueNotifier<bool> descriptionPanelShowStatus =
      ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantInformationBloc>(
      builder: (context, plantInformationBloc, child) {
        this.plantInformationBloc = plantInformationBloc;
        plantInformationBloc.initializeBloc();
        return Scaffold(
          backgroundColor: HexColor("F1F4FB"),
          body: getBody(),
        );
      },
    );
  }

  Container getBody() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 65),
            child: Container(
              height: 230,
              child: ExtendedImage.network(
                widget.plantInformationData.plantImageUrl,
                fit: BoxFit.cover,
                cache: true,
                enableLoadState: true,
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return Text('Loading');
                    case LoadState.completed:
                      return ExtendedRawImage(
                        image: state.extendedImageInfo?.image,
                      );
                    case LoadState.failed:
                      return Text('Load failed');
                  }
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 15),
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    child: IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    child: PlantInformationPageFavouritesButton(
                      onPressed: (isPressed) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          PlantInformationPageInformationPanel(
            plantInformationData: widget.plantInformationData,
            onDetailTap: () {
              descriptionPanelShowStatus.value = true;
            },
          ),
          PlantInformationPageDescriptionPanel(
            text: widget.plantInformationData.plantDescription,
            showStatusNotifier: descriptionPanelShowStatus,
          ),
        ],
      ),
    );
  }
}
