import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class Pot {
  Pot(this.potName, this.imageFilePath);

  final String potName;
  final String imageFilePath;
}

class PlantInformationPagePotSelector extends StatefulWidget {
  PlantInformationPagePotSelector(
      {Key? key,
      required this.itemHeight,
      required this.itemWidth,
      required this.pots,
      required this.itemsPadding,
      required this.onPotSelect})
      : super(key: key);

  final List<Pot> pots;
  final double itemHeight;
  final double itemWidth;
  final double itemsPadding;
  final Function(Pot) onPotSelect;

  @override
  _PlantInformationPagePotSelectorState createState() =>
      _PlantInformationPagePotSelectorState();
}

class _PlantInformationPagePotSelectorState
    extends State<PlantInformationPagePotSelector> {
  final ValueNotifier<int> selectedPotIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    selectedPotIndex.addListener(() {
      widget.onPotSelect(widget.pots[selectedPotIndex.value]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.itemHeight,
      child: ValueListenableBuilder<int>(
        valueListenable: selectedPotIndex,
        builder: (context, value, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return getPotItem(
                context,
                index,
                value,
                widget.pots[index].imageFilePath,
              );
            },
          );
        },
      ),
    );
  }

  Widget getPotItem(BuildContext context, int index, int selectedIndex,
      String imageFilePath) {
    bool isSelected = index == selectedIndex ? true : false;
    return Bounce(
      duration: Duration(milliseconds: 100),
      onPressed: () {
        selectedPotIndex.value = index;
      },
      child: Container(
        width: widget.itemWidth + widget.itemsPadding / 2,
        padding: EdgeInsets.only(right: widget.itemsPadding / 2),
        child: Container(
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                isSelected
                    ? Theme.of(context).accentColor.withOpacity(0.60)
                    : Colors.transparent,
                BlendMode.colorBurn,
              ),
              fit: BoxFit.fill,
              image: AssetImage(
                imageFilePath,
              ),
            ),
          ),
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32.5,
                )
              : Container(),
        ),
      ),
    );
  }
}
