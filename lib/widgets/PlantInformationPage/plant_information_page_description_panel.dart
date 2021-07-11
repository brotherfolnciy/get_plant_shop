import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';

class PlantInformationPageDescriptionPanel extends StatefulWidget {
  PlantInformationPageDescriptionPanel(
      {Key? key, required this.showStatusNotifier, required this.text})
      : super(key: key);

  final String text;
  final ValueNotifier<bool> showStatusNotifier;

  @override
  _PlantInformationPagedescriptionPanelState createState() =>
      _PlantInformationPagedescriptionPanelState();
}

class _PlantInformationPagedescriptionPanelState
    extends State<PlantInformationPageDescriptionPanel>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<bool> showStatusNotifier;

  late AnimationController animationController;
  late EzAnimation showAnimation;
  late EzAnimation hideAnimation;
  late EzAnimation currentAnimation;

  late Size screenSize;

  @override
  void initState() {
    super.initState();
    showStatusNotifier = widget.showStatusNotifier;
    animationController = AnimationController(vsync: this);
    showAnimation = EzAnimation.sequence([
      SequenceItem(0.0, 1.0),
    ], Duration(milliseconds: 200),
        curve: Curves.easeOutQuart, context: context);
    hideAnimation = EzAnimation.sequence(
      [
        SequenceItem(1.0, 0.0),
      ],
      Duration(milliseconds: 200),
      curve: Curves.easeInQuart,
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  EzAnimation animate() {
    if (widget.showStatusNotifier.value) {
      currentAnimation = showAnimation;
      hideAnimation.reset();
      showAnimation.start();
      return currentAnimation;
    } else {
      currentAnimation = hideAnimation;
      showAnimation.reset();
      hideAnimation.start();
      return currentAnimation;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      height: double.infinity,
      width: double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: showStatusNotifier,
        builder: (context, showFlag, child) {
          return AnimatedBuilder(
            animation: animate(),
            builder: (context, child) {
              return Container(
                height: screenSize.height * (currentAnimation.value * 0.516),
                width: screenSize.width,
                padding: EdgeInsets.only(left: 40, right: 40, top: 60),
                color: Colors.white.withOpacity(currentAnimation.value),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        color: Colors.amber,
                        onPressed: () {
                          widget.showStatusNotifier.value = false;
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        iconSize: 32,
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Text(
                            widget.text,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
