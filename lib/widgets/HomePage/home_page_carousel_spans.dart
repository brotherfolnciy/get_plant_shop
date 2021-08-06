import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class HomePageSpansCarousel extends StatefulWidget {
  HomePageSpansCarousel({
    required this.itemsCount,
    required this.spanPadding,
    required this.selectedItemNotifier,
  });

  final int itemsCount;
  final double spanPadding;

  final ValueNotifier<int> selectedItemNotifier;

  @override
  _HomePageSpansCarouselState createState() =>
      new _HomePageSpansCarouselState();
}

class _HomePageSpansCarouselState extends State<HomePageSpansCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final InfiniteScrollController spanController = InfiniteScrollController();
  late EzAnimation animation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this);
    animation = EzAnimation.sequence([
      SequenceItem(widget.spanPadding - 5, 8.0),
    ], Duration(milliseconds: 100), context: context);

    animation.addStatusListener((status) => reverseAnimation(status));

    widget.selectedItemNotifier.addListener(() {
      spanController.animateToItem(widget.selectedItemNotifier.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    animation.removeListener(() => reverseAnimation);
    animation.dispose();
    widget.selectedItemNotifier.dispose();
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
                    controller: spanController,
                    onIndexChanged: (index) {
                      spanController.animateToItem(index);
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
                            color: Theme.of(context).colorScheme.primary,
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
