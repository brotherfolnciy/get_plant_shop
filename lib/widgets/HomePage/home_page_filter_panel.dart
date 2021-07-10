import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterPanelData {
  double filterPriceMin;
  double filterPriceMax;
  String filterPlacementTypeName;
  String filterClimateTypeName;

  FilterPanelData(
    this.filterPriceMin,
    this.filterPriceMax,
    this.filterPlacementTypeName,
    this.filterClimateTypeName,
  );
}

class HomePageFilterPanel extends StatefulWidget {
  HomePageFilterPanel({
    Key? key,
    required this.onSetFilterPanelData,
    required this.showStatusNotifier,
  }) : super(key: key);

  @override
  _HomePageFilterPanelState createState() => _HomePageFilterPanelState();

  final ValueNotifier<bool> showStatusNotifier;
  final Function(FilterPanelData) onSetFilterPanelData;
}

class _HomePageFilterPanelState extends State<HomePageFilterPanel> {
  late FilterPanelData filterPanelData = FilterPanelData(0, 799.0, "", "");
  late SfRangeValues filterPriceRangeValues = SfRangeValues(0.0, 799.0);
  late ValueNotifier<String> currentPlacementSelect = ValueNotifier<String>("");
  late String lastSelectedPlacementType = "";
  late ValueNotifier<String> currentClimateSelect = ValueNotifier<String>("");
  late String lastSelectedClimateType = "";
  late ValueNotifier<SfRangeValues> currentPriceRangeValues =
      ValueNotifier<SfRangeValues>(SfRangeValues(0, 799));

  @override
  void initState() {
    super.initState();
    currentPlacementSelect.addListener(() {
      filterPanelData.filterPlacementTypeName = currentPlacementSelect.value;
      print('${currentPlacementSelect.value} set in filter');
      lastSelectedPlacementType = currentPlacementSelect.value;
    });
    currentClimateSelect.addListener(() {
      filterPanelData.filterClimateTypeName = currentClimateSelect.value;
      print('${currentClimateSelect.value} set in filter');
      lastSelectedClimateType = currentClimateSelect.value;
    });
    currentPriceRangeValues.addListener(() {
      filterPanelData.filterPriceMin = currentPriceRangeValues.value.start;
      filterPanelData.filterPriceMax = currentPriceRangeValues.value.end;
      print(
          '${filterPanelData.filterPriceMin} : ${filterPanelData.filterPriceMax}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: widget.showStatusNotifier,
        builder: (context, value, Widget? child) {
          bool openFlag = value as bool;
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
                          padding:
                              EdgeInsets.only(top: 25, right: 15, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "filters".toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  widget.onSetFilterPanelData(filterPanelData);
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
                        ValueListenableBuilder(
                          valueListenable: currentPlacementSelect,
                          builder: (context, value, Widget? child) {
                            return Container(
                              height: 125,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getPlacementChoiceButton(
                                    'Indoor',
                                    currentPlacementSelect.value,
                                    (placement) {
                                      currentPlacementSelect.value =
                                          lastSelectedPlacementType != 'Indoor'
                                              ? 'Indoor'
                                              : 'None';
                                    },
                                  ),
                                  getPlacementChoiceButton(
                                    'Outdoor',
                                    currentPlacementSelect.value,
                                    (placement) {
                                      currentPlacementSelect.value =
                                          lastSelectedPlacementType != 'Outdoor'
                                              ? 'Outdoor'
                                              : 'None';
                                    },
                                  ),
                                  getPlacementChoiceButton(
                                    'Garden',
                                    currentPlacementSelect.value,
                                    (placement) {
                                      currentPlacementSelect.value =
                                          lastSelectedPlacementType != 'Garden'
                                              ? 'Garden'
                                              : 'None';
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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
                                    "Price Range \$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: currentPriceRangeValues,
                                  builder: (context, value, Widget? child) {
                                    return Container(
                                      height: 75,
                                      child: SfRangeSlider(
                                          min: 1.0,
                                          max: 799.0,
                                          enableTooltip: true,
                                          tooltipShape: SfPaddleTooltipShape(),
                                          activeColor: HexColor("28CA6B"),
                                          values: filterPriceRangeValues,
                                          stepSize: 1.0,
                                          onChanged: (values) {
                                            filterPriceRangeValues = values;
                                            currentPriceRangeValues.value =
                                                filterPriceRangeValues;
                                          }),
                                    );
                                  },
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
                                child: ValueListenableBuilder(
                                  valueListenable: currentClimateSelect,
                                  builder: (context, value, Widget? children) {
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          getClimateChoiceButton(
                                            "assets/images/icons/drop-icon.png",
                                            'Wet',
                                            currentClimateSelect.value,
                                            (climate) {
                                              currentClimateSelect.value =
                                                  lastSelectedClimateType !=
                                                          'Wet'
                                                      ? 'Wet'
                                                      : 'None';
                                            },
                                          ),
                                          getClimateChoiceButton(
                                            "assets/images/icons/sun-icon.png",
                                            'Sunny',
                                            currentClimateSelect.value,
                                            (climate) {
                                              currentClimateSelect.value =
                                                  lastSelectedClimateType !=
                                                          'Sunny'
                                                      ? 'Sunny'
                                                      : 'None';
                                            },
                                          ),
                                          getClimateChoiceButton(
                                            "assets/images/icons/temperature-icon.png",
                                            'Cold',
                                            currentClimateSelect.value,
                                            (climate) {
                                              currentClimateSelect.value =
                                                  lastSelectedClimateType !=
                                                          'Cold'
                                                      ? 'Cold'
                                                      : 'None';
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 100,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 15),
                                child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                      Size(25, 25),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black12),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    height: 25,
                                    width: 45,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "XL   ▴",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
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
      ),
    );
  }

  Widget getPlacementChoiceButton(
      String placementTypeName,
      String selectedPlacementTypeName,
      Function(String) onSelectPlacementType) {
    bool isSelected = selectedPlacementTypeName == placementTypeName;
    return TextButton(
      onPressed: () {
        onSelectPlacementType(placementTypeName);
      },
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
          placementTypeName.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

Widget getClimateChoiceButton(String iconPath, String climateTypeName,
    String selectedClimateTypeName, Function(String) onSelectClimateType) {
  bool isSelected = selectedClimateTypeName == climateTypeName;
  return TextButton(
    onPressed: () {
      onSelectClimateType(climateTypeName);
    },
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        Size(47.5, 47.5),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        isSelected ? HexColor("28CA6B") : Colors.grey.shade50,
      ),
      overlayColor: MaterialStateProperty.all<Color>(
          isSelected ? Colors.white12 : Colors.black12),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: isSelected ? HexColor("28CA6B") : Colors.grey.shade400),
        ),
      ),
      shadowColor: MaterialStateProperty.all<Color>(
        isSelected ? Colors.lightGreen : Colors.white,
      ),
    ),
    child: SizedBox(
      height: 20,
      child: ImageIcon(
        AssetImage(iconPath),
        color: isSelected ? Colors.white : Colors.black,
      ),
    ),
  );
}