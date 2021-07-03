import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class HomePageCarouselItem extends StatelessWidget {
  HomePageCarouselItem(
      {Key? key,
      required this.title,
      required this.sizesTitle,
      required this.imageUrl,
      required this.price})
      : super(key: key);

  final String title;
  final String sizesTitle;
  final String imageUrl;
  final double price;

  late Image image;

  Future getImageFromURL() async {
    await Image.network("$imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    image = getImageFromURL();
    return Container(
      decoration: BoxDecoration(
          color: HexColor("F1F4FB"), borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(left: 35),
            alignment: Alignment.centerLeft,
            child: Text(
              "$title",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 35, top: 3),
            alignment: Alignment.centerLeft,
            child: Text(
              "${sizesTitle.toUpperCase()}",
              style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                  color: HexColor("737373")),
            ),
          ),
          Expanded(
            child: Container(
              child: image != null ? Image.network("$imageUrl") : Container(),
            ),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    textBaseline: TextBaseline.ideographic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        "\$",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$price",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ".00",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 85,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [HexColor("1DAB58"), HexColor("28CA6B")]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
