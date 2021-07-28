import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_shop/widgets/price_text.dart';

class PlantPurchaseItemData {
  final String id;
  final String name;
  final String imageUrl;
  final String potImageUrl;
  final String size;
  final int count;
  final int price;

  PlantPurchaseItemData(this.id, this.name, this.imageUrl, this.potImageUrl,
      this.size, this.count, this.price);
}

class BasketPagePlantPurchasesListItem extends StatefulWidget {
  BasketPagePlantPurchasesListItem({
    Key? key,
    required this.plantPurchase,
    required this.onDismiss,
  }) : super(key: key);

  final PlantPurchaseItemData plantPurchase;

  final Function(String) onDismiss;

  @override
  _BasketPagePlantPurchasesListItemState createState() =>
      _BasketPagePlantPurchasesListItemState();
}

class _BasketPagePlantPurchasesListItemState
    extends State<BasketPagePlantPurchasesListItem> {
  late double cardHeight = 100;

  @override
  Widget build(BuildContext context) {
    cardHeight = 125;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        widget.onDismiss(widget.plantPurchase.id);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: cardHeight,
        padding: EdgeInsets.only(
          top: 7.5,
          bottom: 7.5,
          left: 5,
          right: 15,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: cardHeight,
                width: cardHeight - 25,
                padding: EdgeInsets.symmetric(horizontal: 3.5, vertical: 10),
                child: Stack(
                  children: [
                    ExtendedImage.network(
                      widget.plantPurchase.imageUrl,
                      fit: BoxFit.cover,
                      cache: true,
                      enableLoadState: true,
                      loadStateChanged: (state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return Text('Loading');
                          case LoadState.completed:
                            return ExtendedRawImage(
                              image: state.extendedImageInfo?.image,
                            );
                          case LoadState.failed:
                            return Text('Load failed');
                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(3.5),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5),
                          image: DecorationImage(
                            image: AssetImage(
                              widget.plantPurchase.potImageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      padding: EdgeInsets.only(top: 12.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.plantPurchase.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.plantPurchase.size,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5.5),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Count: ${widget.plantPurchase.count}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: cardHeight,
                width: cardHeight,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(17.5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Price:",
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PriceText(widget.plantPurchase.price, 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
