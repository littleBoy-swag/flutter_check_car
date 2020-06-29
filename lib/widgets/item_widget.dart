import 'package:checkcar/common/common_color.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String label;
  final String content;
  final Color contentColor;

  ItemWidget({@required this.label, @required this.content, this.contentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Color(c_333333)),
          )),
          Text(
            content,
            style:
                TextStyle(color: contentColor ?? Color(c_666666), fontSize: 16),
          )
        ],
      ),
    );
  }
}
