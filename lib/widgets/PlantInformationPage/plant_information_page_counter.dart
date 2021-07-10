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
          height: 36.5,
          width: 111,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 12,
                onPressed: () {
                  setCountValue(-1);
                },
                icon: ImageIcon(
                  AssetImage("assets/images/icons/dicrement-icon.png"),
                ),
              ),
              Text(
                "${count.value}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                iconSize: 18,
                onPressed: () {
                  setCountValue(1);
                },
                icon: Icon(Icons.add),
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
