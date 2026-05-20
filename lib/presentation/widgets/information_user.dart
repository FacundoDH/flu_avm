import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class InformationUser extends StatelessWidget {

  final String name;
  final Position position;
  final Color color;

  const InformationUser({
    super.key,
    required this.name,
    required this.position,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      constraints: BoxConstraints(maxWidth: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.isEmpty ? '_' : name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Text('Lat: ${position.lat.toStringAsFixed(5)}', style: TextStyle(color: Colors.black),),
          Text('Long: ${position.lng.toStringAsFixed(5)}', style: TextStyle(color: Colors.black),),
        ]
      )
    );
  }
}