import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:plant_shop/Controllers/home_page_carousel_controller.dart';
import 'package:plant_shop/widgets/home_page_carousel_item.dart';
import 'package:plant_shop/widgets/home_page_carousel_spans.dart';

class HomePageCarousel extends StatefulWidget {
  HomePageCarousel({
    required this.controller,
    required this.anchor,
    required this.center,
    required this.velocityFactor,
    required this.onSelectedItemChange,
    required this.itemExtent,
    required this.plantsListForBuild,
    required this.onPlantItemTap,
  });

  final HomePageCarouselController controller;

  final double itemExtent;
  final double anchor;
  final bool center;
  final double velocityFactor;

  final List<PlantItemData> plantsListForBuild;

  final Function(int) onPlantItemTap;
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
    widget.controller.addListener(() {
      _controller.animateToItem(widget.controller.selectedItemIndex);
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

    return Container(
      child: Column(
        children: [
          widget.plantsListForBuild.length > 0
              ? Expanded(
                  child: InfiniteCarousel.builder(
                    itemCount: widget.plantsListForBuild.length,
                    itemExtent: widget.itemExtent,
                    center: widget.center,
                    anchor: widget.anchor,
                    loop: false,
                    velocityFactor: widget.velocityFactor,
                    controller: _controller,
                    onIndexChanged: (index) {
                      widget.controller.setValue(index);
                    },
                    itemBuilder: (context, itemIndex, realIndex) {
                      final plant = widget.plantsListForBuild[itemIndex];
                      final currentOffset = widget.itemExtent * realIndex;
                      print(plant.imageUrl);
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
                          padding: EdgeInsets.only(
                              left: 25, right: 20, top: 20, bottom: 20),
                          child: HomePageCarouselItem(
                            onPlantItemTap: (plantId) {
                              widget.onPlantItemTap(plantId);
                            },
                            imageUrl: plant.imageUrl,
                            price: plant.price,
                            sizesTitle: plant.sizesTitle,
                            title: plant.title,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 25),
            child: Container(
              child: HomePageSpansCarousel(
                controller: widget.controller,
                itemsCount: widget.plantsListForBuild.length,
                spanPadding: 11.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
