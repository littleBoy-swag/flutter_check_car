import 'package:flutter/material.dart';

class PopUpWindow extends StatelessWidget {
  final Widget child;
  final Function onClick; //点击child事件
  final double left; //距离左边位置
  final double top;

  PopUpWindow({this.child, this.onClick, this.left, this.top});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              child: GestureDetector(
                  child: child,
                  onTap: () {
                    //点击子child
                    if (onClick != null) {
                      Navigator.of(context).pop();
                      onClick();
                    }
                  }),
              left: left,
              top: top,
            ),
          ],
        ),
      ),
    );
  }
}
