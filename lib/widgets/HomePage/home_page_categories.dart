import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:plant_shop/Controllers/home_page_categories_controller.dart';

class HomePageCategories extends StatefulWidget {
  HomePageCategories({
    required this.categories,
    required this.onSelectedCategoryChange,
    required this.controller,
  });

  final HomePageCategoriesController controller;
  final List<String> categories;

  final Function(String) onSelectedCategoryChange;

  @override
  _HomePageCategoriesState createState() => _HomePageCategoriesState();
}

class _HomePageCategoriesState extends State<HomePageCategories> {
  final ValueNotifier<String> selectedCategory =
      ValueNotifier<String>("Concept");

  final TextStyle menuUnselectTextStyle = TextStyle(
    fontSize: 18.5,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    color: HexColor("#D2D2D2"),
  );
  final TextStyle menuSelectTextStyle = TextStyle(
    fontSize: 18.5,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      selectedCategory.value = widget.controller.selectedCategoriesName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      child: ValueListenableBuilder<String>(
        valueListenable: selectedCategory,
        builder: (context, selectedCategory, child) {
          return Row(
            children: List.generate(
              widget.categories.length,
              (index) {
                return Container(
                  margin: EdgeInsets.only(right: 27.5, left: 7.5),
                  child: getCategoriesItem(index, selectedCategory),
                );
              },
            ),
          );
        },
      ),
    );
  }

  getCategoriesItem(int index, String selectedCategory) {
    bool isSelected = widget.categories[index] == selectedCategory;
    return Container(
      height: 37.5,
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        onPressed: () {
          widget.onSelectedCategoryChange(
            widget.categories[index],
          );
          widget.controller.setValue(widget.categories[index]);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.categories[index],
                style: isSelected ? menuSelectTextStyle : menuUnselectTextStyle,
              ),
              SizedBox(
                height: 4,
              ),
              AnimatedContainer(
                margin: EdgeInsets.only(left: 3),
                duration: Duration(milliseconds: 200),
                height: 3,
                width: isSelected ? 21 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
