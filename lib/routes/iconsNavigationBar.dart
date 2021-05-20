import 'package:flutter/material.dart';

List<Widget> getIcon(){

  double _size =25;
  Color _color = Colors.white70;

  return <Widget>[
    Icon(
      Icons.account_circle,
      size: _size,
      color: _color,
    ),
    Icon(
      Icons.home,
      size: _size,
      color: _color,
    ),
    Icon(
      Icons.info_outline_rounded,
      size: _size,
      color: _color,
    ),
  ];


}