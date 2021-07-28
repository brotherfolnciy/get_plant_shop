import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plant_shop/screens/BasketScreen/BasketBloc.dart';
import 'package:plant_shop/widgets/BasketPage/basket_page_plant_purchases_list_item.dart';
import 'package:plant_shop/widgets/price_text.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatefulWidget {
  BasketScreen({Key? key}) : super(key: key);

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late BasketBloc basketBloc;
  late Size screenSize = MediaQuery.of(context).size;

  late ValueNotifier<bool> showPurchaseListNotifier = ValueNotifier<bool>(true);

  late List<PlantPurchaseItemData> viewPlantPurchasesItemData;

  Tween<Offset> _offSetTween = Tween(
    begin: Offset(1, 0),
    end: Offset.zero,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Consumer<BasketBloc>(
      builder: (context, basketBloc, child) {
        showPurchaseListNotifier.value = true;
        this.basketBloc = basketBloc;
        basketBloc.refreshViewPlantPurchasesDataList();
        viewPlantPurchasesItemData = basketBloc.viewPlantPurchasesItemData;
        return Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        "BUSKET",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      leading: Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      toolbarHeight: 80,
                      centerTitle: false,
                      backgroundColor: Colors.white,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: showPurchaseListNotifier,
                      builder: (context, value, child) {
                        return value
                            ? SliverAnimatedList(
                                key: UniqueKey(),
                                initialItemCount:
                                    viewPlantPurchasesItemData.length,
                                itemBuilder: (context, index, animation) {
                                  return SlideTransition(
                                    position: _offSetTween.animate(animation),
                                    child: BasketPagePlantPurchasesListItem(
                                      plantPurchase:
                                          viewPlantPurchasesItemData[index],
                                      onDismiss: (value) {
                                        basketBloc.removePlantPurchaseById(
                                          viewPlantPurchasesItemData[index].id,
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                            : SliverPadding(
                                padding: EdgeInsets.only(bottom: 0),
                                sliver: SliverToBoxAdapter(
                                  child: Container(
                                    height: screenSize.height * 0.8,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "🛒",
                                          style: TextStyle(fontSize: 32),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Your basket is empty..",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 225),
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream: basketBloc.plantPurchasesDataList,
                initialData: basketBloc.viewPlantPurchasesItemData,
                builder: (context, snapshot) {
                  late List<PlantPurchaseItemData> plantPurchases =
                      snapshot.hasData
                          ? snapshot.data as List<PlantPurchaseItemData>
                          : [];
                  late int totalPrice = 0;
                  if (plantPurchases.length == 0) {
                    Future.delayed(Duration.zero, () async {
                      showPurchaseListNotifier.value = false;
                    });
                  }
                  plantPurchases.forEach((element) {
                    totalPrice += element.price * element.count;
                  });
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: plantPurchases.length > 0 ? 200 : 0,
                      padding: EdgeInsets.only(top: 15, left: 25, right: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, -3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Total Price:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          PriceText(totalPrice, 16),
                          SizedBox(
                            height: 6.5,
                          ),
                          TextButton(
                            onPressed: () {
                              // ! - Добавить отправку запроса на сервер
                              basketBloc.sendPurchasesPlants();
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.white.withOpacity(0.45)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.3),
                              child: Container(
                                height: 45,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                          "assets/images/icons/cart-icon.png"),
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    Text(
                                      'Buy'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
