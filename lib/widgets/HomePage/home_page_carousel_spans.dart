import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:plant_shop/Controllers/home_page_carousel_controller.dart';

class HomePageSpansCarousel extends StatefulWidget {
  HomePageSpansCarousel({
    required this.itemsCount,
    required this.spanPadding,
    required this.controller,
  });

  final int itemsCount;
  final double spanPadding;
  final HomePageCarouselController controller;

  @override
  _HomePageSpansCarouselState createState() =>
      new _HomePageSpansCarouselState();
}

class _HomePageSpansCarouselState extends State<HomePageSpansCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late EzAnimation animation;

  late InfiniteScrollController _spanScrollController;

  @override
  void initState() {
    super.initState();
    _spanScrollController = InfiniteScrollController();

    controller = new AnimationController(vsync: this);
    animation = EzAnimation.sequence([
      SequenceItem(widget.spanPadding - 5, 8.0),
    ], Duration(milliseconds: 100), context: context);

    animation.addStatusListener((status) => reverseAnimation(status));

    widget.controller.addListener(() {
      _spanScrollController.animateToItem(widget.controller.selectedItemIndex);
      animation.start();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    animation.removeListener(() => reverseAnimation);
    animation.dispose();
  }

  startAnimation() {
    animation.start();
  }

  reverseAnimation(dynamic status) {
    if (status == AnimationStatus.completed) {
      animation.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    _spanScrollController.animateToItem(0);
    return widget.itemsCount > 0
        ? SizedBox(
            height: 30,
            width: 150,
            child: Stack(
              children: [
                Container(
                  child: InfiniteCarousel.builder(
                    center: true,
                    loop: false,
                    anchor: 0,
                    controller: _spanScrollController,
                    onIndexChanged: (index) {
                      widget.controller.setValue(index);
                    },
                    itemBuilder: (context, itemIndex, realIndex) {
                      return getCaruselSpan(itemIndex);
                    },
                    itemCount: widget.itemsCount,
                    itemExtent: 30,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Container(
                        height: 19.5,
                        width: 19.5,
                        padding: EdgeInsets.all(animation.value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 0.9),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget getCaruselSpan(int index) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(widget.spanPadding + 1),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getSpanColor(index),
        ),
      ),
    );
  }

  Color? getSpanColor(int index) {
    Color? color;

    int _itemsCount = widget.itemsCount;
    int absMinValue = (0 - index).abs();
    int absMaxValue = (index - widget.itemsCount + 1).abs();

    late int edgeSpanCount;

    if (_itemsCount > 6) {
      edgeSpanCount = 3;
    } else if (_itemsCount < 7 && _itemsCount > 3) {
      edgeSpanCount = 2;
    } else if (_itemsCount < 4) {
      edgeSpanCount = 1;
    }

    if (absMinValue < edgeSpanCount) {
      color = Colors.grey[(edgeSpanCount * 200) - absMinValue * 100];
    } else if (absMaxValue < edgeSpanCount) {
      color = Colors.grey[(edgeSpanCount * 200) - absMaxValue * 100];
    } else {
      color = Colors.grey[edgeSpanCount * 100];
    }

    return color;
  }
}
