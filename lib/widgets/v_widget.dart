import 'package:flutter/material.dart';

class VWidget extends StatelessWidget {
  final double height;

  VWidget({@required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
