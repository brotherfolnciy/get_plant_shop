import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_shop/Controllers/home_page_carousel_controller.dart';
import 'package:plant_shop/Controllers/home_page_categories_controller.dart';
import 'package:plant_shop/screens/BasketScreen/BasketBlocScreen.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBlocScreen.dart';
import 'package:plant_shop/widgets/HomePage/home_page_carousel.dart';
import 'package:plant_shop/widgets/HomePage/home_page_carousel_item.dart';
import 'package:plant_shop/widgets/HomePage/home_page_categories.dart';
import 'package:plant_shop/widgets/HomePage/home_page_filter_panel.dart';
import 'package:plant_shop/widgets/HomePage/home_page_search_input_field.dart';
import 'package:provider/provider.dart';

import 'HomeBloc.dart';

class FilterData {
  String filterName;
  double filterPriceMin;
  double filterPriceMax;
  String filterPlacementTypeName;
  String filterClimateTypeName;

  FilterData(
    this.filterName,
    this.filterPriceMin,
    this.filterPriceMax,
    this.filterPlacementTypeName,
    this.filterClimateTypeName,
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomePageCarouselController homePageCarouselController =
      HomePageCarouselController();
  final HomePageCategoriesController homePageCategoriesController =
      HomePageCategoriesController();

  late ValueNotifier<bool> filterPanelShowStatus = ValueNotifier<bool>(false);
  late ValueNotifier<bool> searchInputFieldShowStatus =
      ValueNotifier<bool>(false);
  late HomeBloc homeBloc;

  late FilterData filterData = FilterData("", 0, 799, "None", "None");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
      builder: (context, homeBloc, child) {
        this.homeBloc = homeBloc;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: getBody(context),
        );
      },
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 125,
      leadingWidth: 75,
      leading: Container(
        padding: EdgeInsets.only(left: 7.5),
        child: IconButton(
          onPressed: () {},
          iconSize: 23,
          icon: ImageIcon(
            AssetImage("assets/images/icons/menu-icon.png"),
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BasketScreen(),
              ),
            );
          },
          iconSize: 23,
          icon: Badge(
            badgeColor: Theme.of(context).accentColor,
            alignment: Alignment.topRight,
            badgeContent: Text(
              "3",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: ImageIcon(
              AssetImage("assets/images/icons/cart-icon.png"),
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 27.5,
        ),
        IconButton(
          onPressed: () {
            !filterPanelShowStatus.value
                ? setSearchInputFieldShowStatus(
                    !searchInputFieldShowStatus.value)
                : print('filter panel must be closed');
          },
          iconSize: 23,
          icon: ImageIcon(
            AssetImage("assets/images/icons/search-icon.png"),
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 17.5,
        )
      ],
    );
  }

  Container getBody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          getAppBar(),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                StreamBuilder<List<PlantItemData>>(
                  stream: homeBloc.plantsList,
                  builder: (context, snapshot) {
                    late List<PlantItemData> plantsDataList = snapshot.hasData
                        ? snapshot.data as List<PlantItemData>
                        : [];
                    return StreamBuilder<List<String>>(
                      stream: homeBloc.categoriesList,
                      builder: (context, snapshot) {
                        late List<String> categories = snapshot.hasData
                            ? snapshot.data as List<String>
                            : [];
                        homeBloc.initializeBloc();
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 85,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              color: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                child: HomePageCategories(
                                  categories: categories,
                                  onSelectedCategoryChange: setSelectedCategory,
                                  controller: homePageCategoriesController,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 17.5),
                                      height: 55,
                                      child: IconButton(
                                        iconSize: 28,
                                        onPressed: () {
                                          !searchInputFieldShowStatus.value
                                              ? setFilterPanelShowStatus(true)
                                              : print(
                                                  'input field must be close');
                                        },
                                        padding: EdgeInsets.all(1),
                                        icon: ImageIcon(
                                          AssetImage(
                                              "assets/images/icons/filter-icon.png"),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: plantsDataList.length > 0
                                          ? HomePageCarousel(
                                              anchor: 0.01,
                                              velocityFactor: 1,
                                              center: false,
                                              itemExtent: 315,
                                              plantsListForBuild:
                                                  plantsDataList,
                                              onPlantItemTap: (plantId) {
                                                routeToPlantInformationScreen(
                                                    context, plantId);
                                              },
                                              onSelectedCardChanges: (index) {},
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  EdgeInsets.only(bottom: 100),
                                              child: Container(
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "🌱",
                                                      style: TextStyle(
                                                          fontSize: 32),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "No plants matching this filter..",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                HomePageFilterPanel(
                  onSetFilterPanelData: setFilterPanelProperties,
                  showStatusNotifier: filterPanelShowStatus,
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 25),
                  child: HomePageSearchInputField(
                    showStatusNotifier: searchInputFieldShowStatus,
                    onInputComplete: setFilterName,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setSelectedCategory(String categoryName) {
    homeBloc.setSelectedCategory(categoryName);
  }

  setFilterName(String filterName) {
    filterData.filterName = filterName;

    setSelectedPlantFilter();
  }

  setFilterPanelProperties(FilterPanelData filterPanelData) {
    filterData.filterPriceMin = filterPanelData.filterPriceMin;
    filterData.filterPriceMax = filterPanelData.filterPriceMax;
    filterData.filterClimateTypeName = filterPanelData.filterClimateTypeName;
    filterData.filterPlacementTypeName =
        filterPanelData.filterPlacementTypeName;

    setSelectedPlantFilter();
  }

  setSelectedPlantFilter() {
    homeBloc.setCurrentFilter(filterData);
    homeBloc.setViewPlantsDataList();
    setFilterPanelShowStatus(false);
  }

  setFilterPanelShowStatus(bool flag) {
    filterPanelShowStatus.value = flag;
  }

  setSearchInputFieldShowStatus(bool flag) {
    searchInputFieldShowStatus.value = flag;
    FocusScope.of(context).unfocus();
  }

  routeToPlantInformationScreen(BuildContext context, int plantId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantInformationScreen(
          plantInformationData:
              homeBloc.getPlantInformationDataFromPlantId(plantId),
        ),
      ),
    );
  }
}
