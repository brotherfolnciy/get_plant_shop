import 'package:flutter/material.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBlocScreen.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_counter.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_description_text.dart';
import 'package:plant_shop/widgets/PlantInformationPage/plant_information_page_pot_selector.dart';
import 'package:plant_shop/widgets/price_text.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      PriceText(widget.plantInformationData.plantPrice),
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
                                onCountChange: (value) {},
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 8,
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
                                    child: PlantInformationPageDescriptionText(
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
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.white.withOpacity(0.45)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                    Container(
                      padding: EdgeInsets.only(top: 25),
                      child: Container(
                        child: Column(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  Container(
                                    height: 45,
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        pageController.animateToPage(0,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeOutQuad);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 7.5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.3),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: Container(
                                child: ListView(
                                  padding: EdgeInsets.only(top: 0, bottom: 0),
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
  }
}
