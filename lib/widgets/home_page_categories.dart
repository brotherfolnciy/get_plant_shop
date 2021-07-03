import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class HomePageCategories extends StatefulWidget {
  const HomePageCategories(
      {required this.categories,
      required this.stream,
      required this.onSelectedCategoryChange});

  final List<String> categories;
  final Stream<int> stream;

  final Function(int) onSelectedCategoryChange;

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
      child: StreamBuilder<int>(
        stream: widget.stream,
        initialData: 1,
        builder: (context, snapshot) {
          int? value = snapshot.data;
          return Row(
            children: List.generate(
              widget.categories.length,
              (index) {
                return Container(
                  child: MaterialButton(
                    onPressed: () {
                      widget.onSelectedCategoryChange(index);
                    },
                    child: Text(
                      widget.categories[index],
                      style: index == value
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
