import 'package:flutter/material.dart';

import '../common/common_color.dart';

class Line extends StatelessWidget {
  final double height;
  final Color color;

  Line({this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 1,
      color: color ?? Color(c_f0f0f0),
    );
  }
}
