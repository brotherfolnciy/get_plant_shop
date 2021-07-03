import 'package:flutter/material.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/widgets/home_page_carousel.dart';
import 'package:plant_shop/widgets/home_page_carousel_spans.dart';
import 'package:plant_shop/widgets/home_page_categories.dart';

import 'HomeBloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = HomeBloc(new Repository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(context),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 125,
      leadingWidth: 75,
      leading: Container(
        padding: EdgeInsets.only(left: 5),
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
          onPressed: () {},
          iconSize: 23,
          icon: ImageIcon(
            AssetImage("assets/images/icons/cart-icon.png"),
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 17.5,
        ),
        IconButton(
          onPressed: () {},
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

  SafeArea getBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 100,
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              child: HomePageCategories(
                categories: ["Concept", "Popular", "New"],
                stream: homeBloc.selectedCategory,
                onSelectedCategoryChange: setSelectedCategory,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 17.5),
                    height: 75,
                    child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(1),
                      icon: ImageIcon(
                        AssetImage("assets/images/icons/filter-icon.png"),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageCarousel(
                      stream: homeBloc.caruselSelectedItem,
                      anchor: 0.0,
                      velocityFactor: 0.2,
                      center: false,
                      itemExtent: 330,
                      onSelectedItemChange: setSelectedItem,
                      itemsCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 25),
            child: Container(
              child: HomePageSpansCarousel(
                stream: homeBloc.caruselSelectedItem,
                itemsCount: 10,
                spanPadding: 11.0,
                onCurrentSpanChange: setSelectedItem,
              ),
            ),
          )
        ],
      ),
    );
  }

  setSelectedItem(int index) {
    homeBloc.setCaruselSelectedItem(index);
    print("Selected item set $index");
  }

  setSelectedCategory(int index) {
    homeBloc.setSelectedCategory(index);
    print("Selected category set $index");
  }
}
