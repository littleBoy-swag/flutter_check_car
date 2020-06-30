import 'package:flutter/material.dart';
import 'package:flutter_tencentplayer/flutter_tencentplayer.dart';

class BottomPlayerWidget extends StatefulWidget {
  final isShow;
  final TencentPlayerController controller;
  final VoidCallback behaviourCallback;
  final ValueChanged<int> changeClear;

  BottomPlayerWidget(
      {this.isShow,
      this.controller,
      this.behaviourCallback,
      this.changeClear});

  @override
  _BottomPlayerWidgetState createState() => _BottomPlayerWidgetState();
}

class _BottomPlayerWidgetState extends State<BottomPlayerWidget> {

  TencentPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.isShow,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // TODO 绘制底部按钮
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
