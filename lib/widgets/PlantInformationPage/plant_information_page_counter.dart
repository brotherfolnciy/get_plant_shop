import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

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
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Bounce(
                    duration: Duration(
                      milliseconds: 100,
                    ),
                    onPressed: () {
                      setCountValue(-1);
                    },
                    child: ImageIcon(
                      AssetImage("assets/images/icons/dicrement-icon.png"),
                      size: 12,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  child: Text(
                    "${count.value}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Bounce(
                    duration: Duration(
                      milliseconds: 100,
                    ),
                    onPressed: () {
                      setCountValue(1);
                    },
                    child: Icon(
                      Icons.add,
                      size: 22,
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
