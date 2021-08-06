import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasketPageSearchInputField extends StatefulWidget {
  const BasketPageSearchInputField({Key? key, required this.onInputComplete})
      : super(key: key);

  final Function(String) onInputComplete;

  @override
  _HomePageSearchInputFieldState createState() =>
      _HomePageSearchInputFieldState();
}

class _HomePageSearchInputFieldState extends State<BasketPageSearchInputField>
    with SingleTickerProviderStateMixin {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode inputFieldFocusNode = FocusNode();

  late String inputText;

  @override
  void initState() {
    super.initState();
    inputText = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.1,
            blurRadius: 3,
            offset: Offset(0, 1),
          )
        ],
      ),
      alignment: Alignment.center,
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[0-9.,]+')),
        ],
        cursorHeight: 20,
        focusNode: inputFieldFocusNode,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 10, bottom: 12, top: 12, right: 10),
          hintText: "  Enter filter name",
        ),
        controller: textEditingController,
        onChanged: (value) {
          inputText = value;
          widget.onInputComplete(inputText);
        },
        onEditingComplete: () {
          widget.onInputComplete(inputText);
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
