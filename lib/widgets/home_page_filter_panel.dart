import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:plant_shop/models/filter.dart';
import 'package:plant_shop/models/plant.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomePageFilterPanel extends StatefulWidget {
  const HomePageFilterPanel(
      {Key? key, required this.onSetPlantFilter, required this.stream})
      : super(key: key);

  @override
  _HomePageFilterPanelState createState() => _HomePageFilterPanelState(false);

  final Stream<bool> stream;
  final Function(PlantFilter) onSetPlantFilter;
}

class _HomePageFilterPanelState extends State<HomePageFilterPanel> {
  late bool isOpen;
  late SfRangeValues filterPriceRangeValues = SfRangeValues(0.0, 100.0);
  _HomePageFilterPanelState(this.isOpen);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      initialData: true,
      builder: (context, snapshot) {
        bool openFlag = snapshot.data as bool;
        return AnimatedContainer(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOutQuint,
          height: openFlag ? MediaQuery.of(context).size.height * 0.605 : 0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.2,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 25, right: 15, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "filters".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                widget.onSetPlantFilter(PlantFilter("", 1, 100,
                                    PlacementType.Garden, ClimateType.Sunny));
                              },
                              icon: ImageIcon(
                                AssetImage(
                                    "assets/images/icons/cross-icon.png"),
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 125,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getPlacementChoiceButton("Indoor", false),
                            getPlacementChoiceButton("Outdoor", true),
                            getPlacementChoiceButton("Garden", false)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 75,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Price Range",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                height: 75,
                                child: SfRangeSlider(
                                    min: 1.0,
                                    max: 100.0,
                                    enableTooltip: true,
                                    tooltipShape: SfPaddleTooltipShape(),
                                    activeColor: HexColor("28CA6B"),
                                    values: filterPriceRangeValues,
                                    stepSize: 1.0,
                                    onChanged: (values) {
                                      setState(() {
                                        filterPriceRangeValues = values;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getClimateChoiceButton(
                                        "assets/images/icons/drop-icon.png",
                                        false),
                                    getClimateChoiceButton(
                                        "assets/images/icons/sun-icon.png",
                                        true),
                                    getClimateChoiceButton(
                                        "assets/images/icons/temperature-icon.png",
                                        false),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getPlacementChoiceButton(String text, bool isSelected) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(
          isSelected ? 5 : 0,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          isSelected ? HexColor("28CA6B") : Colors.grey.shade50,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
            isSelected ? Colors.white12 : Colors.black12),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.5),
            side: BorderSide(
                color: isSelected ? HexColor("28CA6B") : Colors.grey.shade300),
          ),
        ),
        shadowColor: MaterialStateProperty.all<Color>(
          isSelected ? Colors.lightGreen : Colors.white,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.2,
        height: 25,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

Widget getClimateChoiceButton(String iconPath, bool isSelected) {
  return TextButton(
    onPressed: () {},
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        Size(50, 50),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        isSelected ? HexColor("28CA6B") : Colors.grey.shade50,
      ),
      overlayColor: MaterialStateProperty.all<Color>(
          isSelected ? Colors.white12 : Colors.black12),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: isSelected ? HexColor("28CA6B") : Colors.grey.shade400),
        ),
      ),
      shadowColor: MaterialStateProperty.all<Color>(
        isSelected ? Colors.lightGreen : Colors.white,
      ),
    ),
    child: SizedBox(
      child: ImageIcon(
        AssetImage(iconPath),
        color: isSelected ? Colors.white : Colors.black,
      ),
    ),
  );
}
