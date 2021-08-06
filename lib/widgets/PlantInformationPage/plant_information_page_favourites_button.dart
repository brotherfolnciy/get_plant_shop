import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class PlantInformationPageFavouritesButton extends StatefulWidget {
  PlantInformationPageFavouritesButton({Key? key, required this.onPressed})
      : super(key: key);

  final Function(bool) onPressed;

  @override
  _PlantInformationPageFavouritesButtonState createState() =>
      _PlantInformationPageFavouritesButtonState();
}

class _PlantInformationPageFavouritesButtonState
    extends State<PlantInformationPageFavouritesButton> {
  final ValueNotifier<bool> isPressed = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    isPressed.addListener(() {
      widget.onPressed(isPressed.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      child: ValueListenableBuilder<bool>(
        valueListenable: isPressed,
        builder: (context, value, child) {
          return Bounce(
            duration: Duration(milliseconds: 100),
            onPressed: () {
              isPressed.value = !value;
            },
            child: Container(
              alignment: Alignment.center,
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ImageIcon(
                AssetImage("assets/images/icons/heart-icon.png"),
                color: value
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black.withOpacity(0.4),
              ),
            ),
          );
        },
      ),
    );
  }
}
