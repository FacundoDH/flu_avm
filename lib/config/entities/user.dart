//import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../config.dart';

class User {
  final String id;
  final String name;
  final String colorhex;
  final Position position;

  const User({
    required this.id,
    required this.name,
    required this.colorhex,
    required this.position,
  });

  static User fromJson(Map<String, dynamic> json) {
    final lng = json['lng'] as double? ?? 0.0;
    final lat = json['lat'] as double? ?? 0.0;
    final name = json['name'] as String? ?? '';

    return User(
      id: json['id'] as String? ?? '',
      name: name,
      colorhex: json['color'] as String? ?? '#FF0000',
      position: Position(lng, lat),
    );
  }
  
  User copyWith({
    String? id,
    String? name,
    String? colorhex,
    Position? position,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      colorhex: colorhex ?? this.colorhex,
      position: position ?? this.position,
    );
  }
}