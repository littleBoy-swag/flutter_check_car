import 'package:checkcar/common/common_color.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  String content;
  String id;
  VoidCallback callback;
  String groupId;

  CustomRadio(
      {@required this.content,@required this.groupId, @required this.id, @required this.callback});

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        child: Row(
          children: <Widget>[
            Image.asset(
              (widget.id == widget.groupId)
                  ? "images/ic_circle_selected.png"
                  : "images/ic_circle_normal.png",
              width: 15,
              height: 15,
            ),
            SizedBox(width: 6),
            Text(
              widget.content,
              style: TextStyle(fontSize: 14, color: Color(c_333333)),
            )
          ],
        ),
      ),
    );
  }
}
