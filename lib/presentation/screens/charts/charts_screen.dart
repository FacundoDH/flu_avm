import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:flu_avm/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ChartsScreen extends ConsumerStatefulWidget {

  const ChartsScreen({super.key});

  @override
  ConsumerState<ChartsScreen> createState() => _ChartsScreenState();

}

class _ChartsScreenState extends ConsumerState<ChartsScreen> {

  Cancelable? _dragCancelable;

  CircleAnnotationManager? _circleAnnotationManager;

  void _initilizeCircleAnnotations(MapboxMap mapboxmap) {

    mapboxmap.annotations.createCircleAnnotationManager().then((manager) {
      _circleAnnotationManager = manager;

      _setupDragListener(manager);

      _addOrRennovateMarker();
    });
  }

  void _setupDragListener(CircleAnnotationManager manager) {

    _dragCancelable?.cancel();

    _dragCancelable = manager.dragEvents(
      onChanged: (CircleAnnotation annotation) {

        final pos = annotation.geometry.coordinates;

        ref.read(coordsMarkerProvider.notifier).state = pos;
      },
      onEnd: (CircleAnnotation annotation) {

        final pos = annotation.geometry.coordinates;

        ref.read(coordsMarkerProvider.notifier).state = pos;
      }
    );
  }

  Future<void> _addOrRennovateMarker() async {
    final manager = _circleAnnotationManager;
    if (manager == null) return;

    await manager.deleteAll();

    final placed = ref.read(markerPositionedProvider);

    if (!placed) {
      await manager.deleteAll();
      return;
    }

    final site = ref.read(coordsMarkerProvider);

    final color = ref.read(formColorProvider);

    final options = CircleAnnotationOptions(
      geometry: Point(coordinates: site),
      circleColor: color.toARGB32(),
      circleRadius: 14.0,
      circleStrokeColor: Colors.white.toARGB32(),
      isDraggable: true
    );

    try {
      await manager.create(options);
    } catch (e) {
      debugPrint('Error al crear marcador: $e');
    }
  }

  @override
  void dispose() {
    _dragCancelable?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<bool>(markerPositionedProvider, (prev, next) {
      if ( next == true ) _addOrRennovateMarker();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MapWidget(
            key: const ValueKey('main_map'),
            cameraOptions: CameraOptions(
              center: Point(
                coordinates: initializeMarkerPosition,
              ),
              zoom: 14.5,
            ),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _initilizeCircleAnnotations,
          ),
          Align(
            alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ref.watch(markerPositionedProvider)
                  ? InformationUser(
                    name: ref.watch(formNameProvider), 
                    position: ref.watch(coordsMarkerProvider), 
                    color: ref.watch(formColorProvider) 
                ) : CompleteForm(),
              ),
            )
        ]
      )
    );
  }
}