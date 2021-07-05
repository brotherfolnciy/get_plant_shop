import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:plant_shop/models/plant.dart';
import 'package:plant_shop/widgets/home_page_carousel_item.dart';

class HomePageCarousel extends StatefulWidget {
  HomePageCarousel({
    required this.anchor,
    required this.center,
    required this.velocityFactor,
    required this.onSelectedItemChange,
    required this.itemExtent,
    required this.stream,
    required this.plantsListForBuild,
  });

  final Stream<int> stream;
  final double itemExtent;
  final double anchor;
  final bool center;
  final double velocityFactor;
  final List<Plant> plantsListForBuild;

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
    _controller.animateToItem(0);
    widget.stream.listen((event) {
      _controller.animateToItem(event);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.animateToItem(0);
    return InfiniteCarousel.builder(
      itemCount: widget.plantsListForBuild.length,
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
        final plant = widget.plantsListForBuild[itemIndex];
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
            padding: EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 20),
            child: HomePageCarouselItem(
              image: Image.network(plant.imageUrl),
              price: plant.price,
              sizesTitle: "W${plant.width} x H${plant.height}",
              title: plant.name,
            ),
          ),
        );
      },
    );
  }
}
