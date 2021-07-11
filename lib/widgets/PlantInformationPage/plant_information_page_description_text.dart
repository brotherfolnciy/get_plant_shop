import 'dart:ui';

import 'package:flutter/material.dart';

class PlantInformationPageDescriptionText extends StatefulWidget {
  const PlantInformationPageDescriptionText(this.text,
      {required this.style, required this.onDetailTap});

  final String text;
  final TextStyle style;
  final Function() onDetailTap;

  @override
  _PlantInformationPageDescriptionTextState createState() =>
      _PlantInformationPageDescriptionTextState();
}

class _PlantInformationPageDescriptionTextState
    extends State<PlantInformationPageDescriptionText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 56),
            child: Text(
              widget.text,
              style: widget.style,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 13),
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                widget.onDetailTap();
              },
              child: Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 45),
                height: 20,
                width: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1, 0),
                    end: Alignment(-0.2, 0),
                    colors: [
                      Colors.white.withOpacity(0.01),
                      Colors.white,
                    ],
                  ),
                ),
                child: Text(
                  "detail",
                  style: TextStyle(
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(0, -3))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
