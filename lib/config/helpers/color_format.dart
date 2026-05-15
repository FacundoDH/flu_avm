import 'package:flutter/material.dart';

String exColorAsHex(Color color) {
  final String hex = color.toARGB32().toRadixString(16).padLeft(8, '0');
  return '#${hex.substring(2).toUpperCase()}';
}