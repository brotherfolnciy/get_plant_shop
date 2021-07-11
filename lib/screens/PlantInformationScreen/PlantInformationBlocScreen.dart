import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_counter.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_favourites_button.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_pot_selector.dart';
import 'package:plant_shop/widgets/expandable_text.dart';
import 'package:plant_shop/widgets/price_text.dart';
import 'package:provider/provider.dart';

class PlantInformationData {
  final String plantName;
  final int plantPrice;
  final String plantdescription;
  final String plantImageUrl;

  PlantInformationData(this.plantName, this.plantPrice, this.plantdescription,
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
          Container(
            alignment: Alignment.bottomCenter,
            height: double.infinity,
            width: double.infinity,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.616,
              padding: EdgeInsets.only(left: 40, right: 40, top: 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.1,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.plantInformationData.plantName}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PriceText(widget.plantInformationData.plantPrice),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.centerLeft,
                        child: PlantInformationPageCounter(
                          onCountChange: (value) {},
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Pot".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PlantInformationPagePotSelector(
                            itemHeight: 80,
                            itemWidth: 80,
                            itemsPadding: 40,
                            pots: [
                              Pot('', 'assets/images/pots/pot_1.png'),
                              Pot('', 'assets/images/pots/pot_2.png'),
                              Pot('', "assets/images/pots/pot_3.png"),
                            ],
                            onPotSelect: (pot) {},
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 35),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              height: 90,
                              alignment: Alignment.centerLeft,
                              child: ExpandableText(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lobortis erat. Cras sit amet imperdiet sapien. Pellentesque feugiat sem nunc, eget pharetra ante pulvinar eget",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.white.withOpacity(0.45)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 70),
                          child: Container(
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                      "assets/images/icons/cart-icon.png"),
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  'Add to cart'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Text('${widget.plantInformationData.plantName}'),
          // Text('${widget.plantInformationData.plantPrice}'),
          // Text('${widget.plantInformationData.plantdescription}'),
        ],
      ),
    );
  }

  Widget getPotItem(String potName, String currentPotName, String imageUrl) {
    bool isSelected = currentPotName == potName ? true : false;
    return Container(
      width: 85,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
