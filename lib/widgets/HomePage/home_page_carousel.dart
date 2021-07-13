import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:plant_shop/Controllers/home_page_carousel_controller.dart';
import 'package:plant_shop/widgets/HomePage/home_page_carousel_item.dart';
import 'package:plant_shop/widgets/HomePage/home_page_carousel_spans.dart';

class HomePageCarousel extends StatefulWidget {
  HomePageCarousel({
    required this.onSelectedCardChanges,
    required this.anchor,
    required this.center,
    required this.velocityFactor,
    required this.itemExtent,
    required this.plantsListForBuild,
    required this.onPlantItemTap,
  });

  final Function(int) onSelectedCardChanges;

  final double itemExtent;
  final double anchor;
  final bool center;
  final double velocityFactor;

  final List<PlantItemData> plantsListForBuild;

  final Function(int) onPlantItemTap;

  @override
  _HomePageCarouselState createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  final InfiniteScrollController _cardsController = InfiniteScrollController();
  late ValueNotifier<int> selectedItemNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _cardsController,
                    onIndexChanged: (index) {
                      widget.onSelectedCardChanges(index);
                      selectedItemNotifier.value = index;
                    },
                    itemBuilder: (context, itemIndex, realIndex) {
                      final plant = widget.plantsListForBuild[itemIndex];
                      final currentOffset = widget.itemExtent * realIndex;
                      print(plant.imageUrl);
                      return AnimatedBuilder(
                        animation: _cardsController,
                        builder: (context, child) {
                          final diff =
                              (_cardsController.offset - currentOffset);
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
                              left: 25, right: 10, top: 20, bottom: 20),
                          child: HomePageCarouselItem(
                            onPlantItemTap: (plantId) {
                              widget.onPlantItemTap(plantId);
                            },
                            imageUrl: plant.imageUrl,
                            price: plant.price,
                            sizesTitle: plant.sizesTitle,
                            title: plant.title,
                            id: plant.plantId,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 25),
            child: Container(
              child: HomePageSpansCarousel(
                itemsCount: widget.plantsListForBuild.length,
                spanPadding: 11.5,
                selectedItemNotifier: selectedItemNotifier,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
