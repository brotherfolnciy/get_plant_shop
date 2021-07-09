import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class PlantItemData {
  PlantItemData(
    this.plantId,
    this.title,
    this.sizesTitle,
    this.price,
    this.imageUrl,
  );
  final int plantId;
  final String title;
  final String sizesTitle;
  final int price;
  final String imageUrl;
}

class HomePageCarouselItem extends StatefulWidget {
  HomePageCarouselItem(
      {Key? key,
      required this.title,
      required this.sizesTitle,
      required this.price,
      required this.imageUrl,
      required this.onPlantItemTap,
      required this.id})
      : super(key: key);

  final int id;
  final String title;
  final String sizesTitle;
  final int price;
  final String imageUrl;
  final Function(int) onPlantItemTap;

  @override
  _HomePageCarouselItemState createState() => _HomePageCarouselItemState();
}

class _HomePageCarouselItemState extends State<HomePageCarouselItem> {
  final TextStyle itemMessageTextStyle = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    color: HexColor("#D2D2D2"),
  );

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 75),
      onPressed: () {
        widget.onPlantItemTap(widget.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: HexColor("F1F4FB"),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.only(left: 35),
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.title}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 36, top: 3),
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.sizesTitle.toUpperCase()}",
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: HexColor("737373"),
                    letterSpacing: 0.04),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: widget.imageUrl.isNotEmpty
                    ? ExtendedImage.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        cache: true,
                        enableLoadState: true,
                        loadStateChanged: (state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return getItemMessage('Loading');
                            case LoadState.completed:
                              return ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                              );
                            case LoadState.failed:
                              return getItemMessage("Load failed");
                          }
                        },
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: getItemMessage('Missing image url'),
                      ),
              ),
            ),
            Container(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 27.5),
                    height: 40,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.ideographic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.price}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ".00",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        HexColor("28CA6B"),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0),
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                        HexColor("F1F4FB").withOpacity(0.4),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(35),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            HexColor("28CA6B"),
                            HexColor("1DAB58"),
                          ],
                        ),
                      ),
                      child: Container(
                        height: 90,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getItemMessage(String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(text, style: itemMessageTextStyle),
    );
  }
}
