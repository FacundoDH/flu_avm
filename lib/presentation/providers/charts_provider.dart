import 'package:flu_avm/services/charts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

final formNameProvider = StateProvider<String>((ref) => '');

final formColorProvider = StateProvider<Color>((ref) => Colors.red);

final markerPositionedProvider = StateProvider<bool>((ref) => false);

final Position initializeMarkerPosition = Position(-122.467895, 37.800126);

final coordsMarkerProvider = StateProvider<Position>((ref) => initializeMarkerPosition);

final socketServiceProvider = Provider<ChartService>((ref) {
  final service = ChartService();

  ref.onDispose(service.finish);

  return service;
});