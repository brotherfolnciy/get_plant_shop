import 'package:flutter/material.dart';

class PlantInformationPageCounter extends StatefulWidget {
  PlantInformationPageCounter({Key? key, required this.onCountChange})
      : super(key: key);

  final Function(int) onCountChange;

  @override
  _PlantInformationPageCounterState createState() =>
      _PlantInformationPageCounterState();
}

class _PlantInformationPageCounterState
    extends State<PlantInformationPageCounter> {
  final ValueNotifier<int> count = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    count.addListener(() {
      if (count.value < 1) count.value = 1;
      widget.onCountChange(count.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: count,
      builder: (context, value, child) {
        return Container(
          height: 32.5,
          width: count.value < 100 ? 105 : 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 32.5,
                child: TextButton(
                  onPressed: () {
                    setCountValue(-1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: ImageIcon(
                      AssetImage("assets/images/icons/dicrement-icon.png"),
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.black12),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3.5),
                          bottomLeft: Radius.circular(3.5),
                        ),
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${count.value}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 32.5,
                child: TextButton(
                  onPressed: () {
                    setCountValue(1);
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    alignment: Alignment.center,
                    child: ImageIcon(
                      AssetImage("assets/images/icons/increment-icon.png"),
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.black12),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3.5),
                          bottomRight: Radius.circular(3.5),
                        ),
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  setCountValue(int value) {
    count.value += value;
  }
}
