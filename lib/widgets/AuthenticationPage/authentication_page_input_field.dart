import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationPageInputField extends StatefulWidget {
  AuthenticationPageInputField(
      {Key? key,
      required this.hintText,
      required this.onEditing,
      required this.lettersOnly,
      required this.obscureText})
      : super(key: key);

  final String hintText;
  final Function(String) onEditing;
  final bool lettersOnly;
  final bool obscureText;

  @override
  _AuthenticationPageInputFieldState createState() =>
      _AuthenticationPageInputFieldState();
}

class _AuthenticationPageInputFieldState
    extends State<AuthenticationPageInputField> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode inputFieldFocusNode = FocusNode();
  final ValueNotifier<bool> visibility = ValueNotifier<bool>(true);

  late String text = '';

  @override
  void initState() {
    super.initState();
    visibility.value = widget.obscureText ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: visibility,
        builder: (context, value, child) {
          return TextField(
            inputFormatters: [
              widget.lettersOnly
                  ? FilteringTextInputFormatter.deny(RegExp('[0-9.,]+'))
                  : FilteringTextInputFormatter.deny(RegExp('')),
            ],
            obscureText: value ? true : false,
            cursorHeight: 20,
            focusNode: inputFieldFocusNode,
            keyboardType: TextInputType.text,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Theme.of(context).colorScheme.primary,
            decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        visibility.value = !visibility.value;
                      },
                      icon:
                          Icon(value ? Icons.visibility : Icons.visibility_off),
                    )
                  : SizedBox(
                      width: 1,
                      height: 1,
                    ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 20, bottom: 12, top: 12, right: 10),
              hintText: " ${widget.hintText}",
            ),
            controller: textEditingController,
            onChanged: (value) {
              text = value;
              widget.onEditing(text);
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              widget.onEditing(text);
            },
          );
        },
      ),
    );
  }
}
