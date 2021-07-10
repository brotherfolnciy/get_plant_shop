import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText(this.price);

  final int price;

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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              "$price",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              ".00",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
