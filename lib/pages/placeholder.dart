import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  @required
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
