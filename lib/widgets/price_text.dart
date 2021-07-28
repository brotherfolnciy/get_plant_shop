import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText(this.price, this.fontSize);

  final int price;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              "\$",
              style: TextStyle(
                  fontSize: fontSize - 8, fontWeight: FontWeight.bold),
            ),
            Text(
              "$price",
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              ".00",
              style: TextStyle(
                  fontSize: fontSize - 6, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
