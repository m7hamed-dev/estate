import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  const Txt(
    this.title, {
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);
  final String title;
  final double? fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      softWrap: false,
      style: TextStyle(
        fontSize: fontSize ?? 17.0,
        // fontFamily: 'Roboto',
        overflow: TextOverflow.fade,
        color: color ?? const Color(0xFF212121),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
