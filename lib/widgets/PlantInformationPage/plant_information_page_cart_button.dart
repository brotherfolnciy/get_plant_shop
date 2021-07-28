import 'package:flutter/material.dart';

class PlantInformationPageCartButton extends StatefulWidget {
  PlantInformationPageCartButton(
      {Key? key, required this.onPressed, required this.onSecondPressed})
      : super(key: key);

  final Function() onPressed;
  final Function() onSecondPressed;

  @override
  _PlantInformationPageCartButtonState createState() =>
      _PlantInformationPageCartButtonState();
}

class _PlantInformationPageCartButtonState
    extends State<PlantInformationPageCartButton> {
  late bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!isPressed) {
          widget.onPressed();
          setState(() {
            isPressed = true;
          });
        } else {
          widget.onSecondPressed();
        }
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          isPressed
              ? Colors.black.withOpacity(0.45)
              : Colors.white.withOpacity(0.45),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            isPressed ? Colors.white : Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Container(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageIcon(
                AssetImage("assets/images/icons/cart-icon.png"),
                color: isPressed ? Colors.black : Colors.white,
                size: 18,
              ),
              Text(
                isPressed
                    ? 'Go to cart'.toUpperCase()
                    : 'Add to cart'.toUpperCase(),
                style: TextStyle(
                  color: isPressed ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
