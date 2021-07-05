import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class HomePageCategories extends StatefulWidget {
  const HomePageCategories(
      {required this.categories,
      required this.stream,
      required this.onSelectedCategoryChange});

  final List<String> categories;
  final Stream<String> stream;

  final Function(String) onSelectedCategoryChange;

  static TextStyle menuUnselectTextStyle = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w700, color: HexColor("#D2D2D2"));
  static TextStyle menuSelectTextStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black);

  @override
  _HomePageCategoriesState createState() => _HomePageCategoriesState();
}

class _HomePageCategoriesState extends State<HomePageCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<String>(
        stream: widget.stream,
        initialData: "concept",
        builder: (context, snapshot) {
          String? value = snapshot.data;
          return Row(
            children: List.generate(
              widget.categories.length,
              (index) {
                return Container(
                  child: MaterialButton(
                    onPressed: () {
                      widget.onSelectedCategoryChange(widget.categories[index]);
                    },
                    child: Text(
                      widget.categories[index],
                      style: widget.categories[index] == value
                          ? HomePageCategories.menuSelectTextStyle
                          : HomePageCategories.menuUnselectTextStyle,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
