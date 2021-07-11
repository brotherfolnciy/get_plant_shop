import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text, {required this.style});

  final String text;
  final TextStyle style;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new AnimatedSize(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        child: new ConstrainedBox(
          constraints: widget.isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(
                  maxHeight: 53.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: new Text(
            widget.text,
            style: widget.style,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
      widget.isExpanded
          ? new ConstrainedBox(constraints: new BoxConstraints())
          : new GestureDetector(
              child: const Text('...'),
              onTap: () => setState(
                () => widget.isExpanded = true,
              ),
            )
    ]);
  }
}
