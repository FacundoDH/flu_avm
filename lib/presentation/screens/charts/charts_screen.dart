// TEMPORAL: Pantalla de mapa desactivada para desarrollo en Chrome
// Para reactivar: borrar el widget temporal de abajo y descomentar todo el bloque original

// --- INICIO CÓDIGO ORIGINAL ---

/*import 'package:flu_avm/config/helpers/color_format.dart';
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

    final socketService = ref.read(socketServiceProvider);

    _dragCancelable = manager.dragEvents(
      onChanged: (CircleAnnotation annotation) {

        final pos = annotation.geometry.coordinates;

        ref.read(coordsMarkerProvider.notifier).state = pos;

        socketService.emitPosition(pos);
      },
      onEnd: (CircleAnnotation annotation) {

        final pos = annotation.geometry.coordinates;

        ref.read(coordsMarkerProvider.notifier).state = pos;

        socketService.emitPosition(pos);
      }
    );
  }

  Future<void> _addOrRennovateMarker() async {
    final manager = _circleAnnotationManager;
    if (manager == null) return;

    await manager.deleteAll();

    final placed = ref.read(markerPositionedProvider);

    /*if (!placed) {
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
    }*/

    if (placed) {
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

    final otherRaw = ref.read(otherUsersProvider).value ?? [];

    final myId = ref.read(socketServiceProvider).mySocketId;

    final others = otherRaw.where((u) => u.id != myId).toList();

    for (final user in others) {
      final userColor = exHexToColor(user.colorhex);

      final othersOptions = CircleAnnotationOptions(
        geometry: Point(coordinates: user.position),
        circleColor: userColor.toARGB32(),
        circleRadius: 14.0,
        circleStrokeColor: Colors.white.toARGB32(),
        isDraggable: false
      );

      try {
        await manager.create(othersOptions);
      } catch (e) {
        debugPrint('Error al crear marcadorde otros usuarios: $e');
      }
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

    ref.listen(otherUsersProvider, (prev, next) {
      _addOrRennovateMarker();
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
}*/

// TEMPORAL: placeholder mientras se desarrolla en Chrome
import 'package:flutter/material.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapas')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Mapa desactivado temporalmente',
                style: TextStyle(color: Colors.grey)),
            Text('(solo disponible en Android/iOS)',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}