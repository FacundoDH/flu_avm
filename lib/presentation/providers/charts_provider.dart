import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final formNameProvider = StateProvider<String>((ref) => '');

final formColorProvider = StateProvider<Color>((ref) => Colors.red);