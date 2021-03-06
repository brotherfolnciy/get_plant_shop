import 'package:flutter/material.dart';
import 'package:plant_shop/screens/BasketScreen/BasketBlocScreen.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBlocScreen.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_cart_button.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_counter.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_description_text.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_pot_selector.dart';
import 'package:plant_shop/widgets/price_text.dart';
import 'package:provider/provider.dart';

class PlantInformationPageInformationPanel extends StatefulWidget {
  PlantInformationPageInformationPanel({required this.plantInformationData});

  final PlantInformationData plantInformationData;

  @override
  _PlantInformationPageInformationPanelState createState() =>
      _PlantInformationPageInformationPanelState();
}

class _PlantInformationPageInformationPanelState
    extends State<PlantInformationPageInformationPanel> {
  late PageController pageController = PageController();
  late PotData selectedPotData;
  late int count;

  @override
  void initState() {
    super.initState();
    selectedPotData = PotData("1", "assets/images/pots/pot_1.png");
    count = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantInformationBloc>(
      builder: (context, plantInformationBloc, child) {
        return Container(
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
                      padding: EdgeInsets.only(top: 0, bottom: 0),
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
                          PriceText(widget.plantInformationData.plantPrice, 22),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      allowImplicitScrolling: false,
                      controller: pageController,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Flexible(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.only(top: 30),
                                  alignment: Alignment.centerLeft,
                                  child: PlantInformationPageCounter(
                                    onCountChange: (value) {
                                      count = value;
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 5),
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
                                        PotData('1',
                                            'assets/images/pots/pot_1.png'),
                                        PotData('2',
                                            'assets/images/pots/pot_2.png'),
                                        PotData('3',
                                            "assets/images/pots/pot_3.png"),
                                      ],
                                      onPotSelect: (potData) {
                                        selectedPotData = potData;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(),
                              ),
                              Flexible(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.only(),
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
                                        padding: EdgeInsets.only(top: 3),
                                        alignment: Alignment.centerLeft,
                                        child:
                                            PlantInformationPageDescriptionText(
                                          widget.plantInformationData
                                              .plantDescription,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black38,
                                          ),
                                          onDetailTap: () {
                                            pageController.animateToPage(1,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeOutQuad);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 4,
                                child: PlantInformationPageCartButton(
                                  onPressed: () {
                                    plantInformationBloc.addPlantPurchase(
                                        widget.plantInformationData.plantName,
                                        count,
                                        selectedPotData);
                                  },
                                  onSecondPressed: () {
                                    routeToBasketScreen(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 25, bottom: 15),
                          child: Container(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 33,
                                        alignment: Alignment.centerLeft,
                                        child: TextButton(
                                          onPressed: () {
                                            pageController.animateToPage(
                                              0,
                                              duration:
                                                  Duration(milliseconds: 200),
                                              curve: Curves.easeOutQuad,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Description".toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.3,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 2, left: 15),
                                                  alignment: Alignment.center,
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/images/icons/cross-icon.png"),
                                                    color: Colors.black,
                                                    size: 13.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(Colors.white),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.5),
                                                side: BorderSide(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 8,
                                  child: Container(
                                    child: ListView(
                                      padding:
                                          EdgeInsets.only(top: 7.5, bottom: 15),
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        Text(
                                          widget.plantInformationData
                                              .plantDescription,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  routeToBasketScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BasketScreen(),
      ),
    );
  }
}
