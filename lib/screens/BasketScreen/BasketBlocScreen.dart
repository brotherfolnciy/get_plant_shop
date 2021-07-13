import 'package:flutter/material.dart';

class BasketScreen extends StatefulWidget {
  BasketScreen({Key? key}) : super(key: key);

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Container getBody() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        "Basket Page",
      ),
    );
  }
}
