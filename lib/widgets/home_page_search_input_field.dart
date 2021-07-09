import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageSearchInputField extends StatefulWidget {
  const HomePageSearchInputField(
      {Key? key,
      required this.showStatusNotifier,
      required this.onInputComplete})
      : super(key: key);

  final ValueNotifier<bool> showStatusNotifier;
  final Function(String) onInputComplete;

  @override
  _HomePageSearchInputFieldState createState() =>
      _HomePageSearchInputFieldState();
}

class _HomePageSearchInputFieldState extends State<HomePageSearchInputField>
    with SingleTickerProviderStateMixin {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode inputFieldFocusNode = FocusNode();

  late AnimationController animationController;
  late EzAnimation showAnimation;
  late EzAnimation hideAnimation;
  late EzAnimation currentAnimation;

  late String inputText;

  @override
  void initState() {
    super.initState();
    inputText = '';
    animationController = AnimationController(vsync: this);
    showAnimation = EzAnimation.sequence([
      SequenceItem(0.0, 1.0),
    ], Duration(milliseconds: 200),
        curve: Curves.easeOutQuart, context: context);
    hideAnimation = EzAnimation.sequence(
      [
        SequenceItem(1.0, 0.0),
      ],
      Duration(milliseconds: 200),
      curve: Curves.easeInQuart,
      context: context,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  EzAnimation animate() {
    if (widget.showStatusNotifier.value) {
      currentAnimation = showAnimation;
      hideAnimation.reset();
      showAnimation.start();
      return currentAnimation;
    } else {
      currentAnimation = hideAnimation;
      showAnimation.reset();
      hideAnimation.start();
      return currentAnimation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.showStatusNotifier,
      builder: (context, value, child) {
        return AnimatedBuilder(
          animation: animate(),
          builder: (context, child) {
            return Opacity(
              opacity: currentAnimation.value,
              child: Container(
                width: currentAnimation.value *
                    MediaQuery.of(context).size.width *
                    0.9,
                height: 50,
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
                  cursorColor: Theme.of(context).accentColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 10, bottom: 12, top: 12, right: 10),
                    hintText: "  Enter filter name",
                  ),
                  controller: textEditingController,
                  onChanged: (value) {
                    inputText = value;
                  },
                  onEditingComplete: () {
                    widget.onInputComplete(inputText);
                    widget.showStatusNotifier.value = false;
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
