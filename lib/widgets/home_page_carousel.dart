import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:plant_shop/widgets/home_page_carousel_item.dart';

class HomePageCarousel extends StatefulWidget {
  HomePageCarousel(
      {required this.itemsCount,
      required this.anchor,
      required this.center,
      required this.velocityFactor,
      required this.onSelectedItemChange,
      required this.itemExtent,
      required this.stream});

  final Stream<int> stream;
  final int itemsCount;
  final double itemExtent;
  final double anchor;
  final bool center;
  final double velocityFactor;

  final Function(int) onSelectedItemChange;

  @override
  _HomePageCarouselState createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  late InfiniteScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InfiniteScrollController();
    widget.stream.listen((event) {
      _controller.animateToItem(event);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  setCurrentItem(int index) {
    _controller.animateToItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      itemCount: widget.itemsCount,
      itemExtent: widget.itemExtent,
      center: widget.center,
      anchor: widget.anchor,
      loop: false,
      velocityFactor: widget.velocityFactor,
      controller: _controller,
      onIndexChanged: (index) {
        widget.onSelectedItemChange(index);
      },
      itemBuilder: (context, itemIndex, realIndex) {
        final currentOffset = widget.itemExtent * realIndex;
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final diff = (_controller.offset - currentOffset);
            final maxPadding = 15.0;
            final _carouselRatio = 120 / maxPadding;

            return Padding(
              padding: EdgeInsets.only(
                top: (diff / _carouselRatio).abs(),
                bottom: (diff / _carouselRatio).abs(),
              ),
              child: child,
            );
          },
          child: Padding(
              padding:
                  EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 20),
              child: HomePageCarouselItem(
                imageUrl:
                    "https://clipart-best.com/img/bush/bush-clip-art-2.png",
                price: 228,
                sizesTitle: 'w 300 × h 310 mm',
                title: 'Gasteri Kyoryu',
              )),
        );
      },
    );
  }
}
