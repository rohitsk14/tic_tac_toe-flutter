import 'package:flutter/material.dart';

class GameButton {
  final int id;
  String title;
  Color bgColor;
  bool enabled;

  GameButton({this.id, this.title = '', this.bgColor, this.enabled = true});
}
