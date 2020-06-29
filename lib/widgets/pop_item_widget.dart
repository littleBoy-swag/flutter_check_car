import 'package:flutter/material.dart';

import '../common/common_color.dart';
import '../common/common_style.dart';
import '../common/common_style.dart';

class PopItemWidget extends StatefulWidget {
  final String prefix;
  final String suffix;
  final String iconPath;
  final bool showLine;
  final VoidCallback callback;

  PopItemWidget(
      {@required this.prefix,
      @required this.suffix,
      this.iconPath,
      this.showLine = true,
      this.callback});

  @override
  _PopItemWidgetState createState() => _PopItemWidgetState();
}

class _PopItemWidgetState extends State<PopItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Color(c_f0f0f0))),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              widget.prefix,
              style: itemStyle,
            )),
            Text(
              widget.suffix,
              style: itemStyle,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Image.asset(
                widget.iconPath,
                width: 16,
                height: 16,
              ),
            )
          ],
        ),
      ),
      onTap: widget.callback,
    );
  }
}
