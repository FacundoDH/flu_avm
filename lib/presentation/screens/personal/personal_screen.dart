import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

class TextSegment {
  final String text;
  final bool isGlitch;

  const TextSegment(
    this.text,
    {this.isGlitch = false});
}

class Scene {
  final String imagePath;
  final String title;
  final List<TextSegment> body;
  final Alignment alignment;

  const Scene({
    required this.imagePath,
    required this.title,
    required this.body,
    this.alignment = Alignment.center,
  });
}

const List<Scene> scenes = [
  Scene(
    imagePath: 'assets/images/personal/personal_1.jpg',
    title: '33°17′33″N  44°03′54″E_Irak',
    body: [
      TextSegment('_Prisión de Abu Ghraib. Usada por el '),
      TextSegment('gobierno', isGlitch: true),
      TextSegment(' de los'),
      TextSegment('Estados Unidos', isGlitch: true), 
      TextSegment('. Como centro de reclusos durante la Guerra de Irak.'),
      ],
    alignment: Alignment.bottomLeft,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_2.jpg',
    title: 'La Verdad y "La Verdad"',
    body: [
      TextSegment('_Imágenes del personal, y los '),
      TextSegment('prisioneros', isGlitch: true), 
      TextSegment(' salen a la luz en el año 2004. '),
      TextSegment('El relato de Occidente sobre una lucha por la '),
      TextSegment('libertad', isGlitch: true),
      TextSegment(' se vuelve completamente '),
      TextSegment('insostenible', isGlitch: true),
      TextSegment('.'),
      ],
    alignment: Alignment.center,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_3.jpg',
    title: '_ERROR: CONTRADICTION',
    body: [
      TextSegment('Se revela que los prisioneros eran sometidos a prácticas '),
      TextSegment('humillantes', isGlitch: true), 
      TextSegment(' y '),
      TextSegment('torturas continuas', isGlitch: true),
      TextSegment(' mientras estaban '),
      TextSegment('recluidos', isGlitch: true),
      TextSegment(' en las instalaciones.'),
      ],
    alignment: Alignment.topRight,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_4.jpg',
    title: 'OPEN: _MASS DESTRUCTION WEAPONS',
    body: [
      TextSegment('"En esta guerra [...] nuestra causa es justa: la '),
      TextSegment('seguridad', isGlitch: true), 
      TextSegment(' de las naciones a las que servimos y '),
      TextSegment('la paz mundial', isGlitch: true), 
      TextSegment('."'), 
      TextSegment(' ¿Era esto la verdad, o "la verdad"?', isGlitch: true), 
      ],
    alignment: Alignment.topLeft,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_5.jpg',
    title: 'SEARCHING...',
    body: [
      TextSegment('"En este conflicto, las fuerzas estadounidenses y la coalición se enfrentan a '),
      TextSegment('enemigos', isGlitch: true), 
      TextSegment(' que no respetan las ocnvenciones de la '),
      TextSegment('guerra', isGlitch: true),
      TextSegment(' ni las '),
      TextSegment('normas morales', isGlitch: true),
      TextSegment('."'),
      ],
    alignment: Alignment.bottomRight,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_6.jpg',
    title: 'SEARCHING...',
    body: [
      TextSegment('"Millones de estadounidenses rezan con ellos por la '),
      TextSegment('seguridad', isGlitch: true), 
      TextSegment(' de sus '),
      TextSegment('seres queridos', isGlitch: true),
      TextSegment(' y por la protección de todos los '),
      TextSegment('inocentes', isGlitch: true),
      TextSegment('."'),
      
      ],
    alignment: Alignment.bottomRight,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_7.jpg',
    title: 'ERROR: _MASS DESTRUCTION WEAPONS (NOT FOUND)',
    body: [
      TextSegment('"Todas las familias con seres queridos sirviendo en esta guerra pueden tener algo presente: Nuestras fuerzas volverán a casa tan pronto como terminen '),
      TextSegment('su misión', isGlitch: true),
      TextSegment('. [...] Nuestra nación entró en este conflicto a regañadientes, '),
      TextSegment('pero con un propósito claro y firme', isGlitch: true), 
      TextSegment('. [...] la unica forma de limitar su duración es aplicar la '),
      TextSegment('fuerza decisiva', isGlitch: true),
      TextSegment('."'),
      ],
    alignment: Alignment.bottomRight,
  ),
];

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {

  final ScrollController _scrollController = ScrollController();
  int _currentScene = 0;
  double _fadeProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {

    final screenHeight = MediaQuery.of(context).size.height;
    final offset = _scrollController.offset;

    final int rawIndex = (offset / screenHeight).floor();
    final int sceneIndex = (rawIndex % scenes.length);

    final double progress = (offset % screenHeight) / screenHeight;

    final double fadeProgress = progress < 0.4
      ? 0.0
      : ((progress - 0.4) / 0.6).clamp(0.0, 1.0);

    setState(() {
      _currentScene = sceneIndex;
      _fadeProgress = fadeProgress;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final int nextScene = (_currentScene + 1) % scenes.length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedOpacity(
          opacity: _currentScene == 0 ? (1.0 - _fadeProgress) : 0.0,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            title: Text('Abu Ghraib'),
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IgnorePointer(
              ignoring: _currentScene != 0,
              child: IconButton(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [

              Positioned.fill(
                child: Image.asset(
                  scenes[_currentScene].imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Opacity(
                  opacity: _fadeProgress,
                  child: Image.asset(
                    scenes[nextScene].imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned.fill(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 999999,
                  itemBuilder: (context, index) {
                    final scene = scenes[index % scenes.length];
                    return Container(
                      height: constraints.maxHeight,
                      padding: EdgeInsets.symmetric(horizontal:32, vertical:64),
                      child: Align(
                        alignment: scene.alignment,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.black.withValues(alpha: 0.8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          
                              Text(
                                scene.title,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 4,
                                ),
                              ),
                          
                              SizedBox(height:10),
                          
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 14,
                                    color: Colors.white,
                                    height: 1.8,
                                    letterSpacing: 1.2,
                                  ),
                                  children: scene.body.map((segment) {
                                    if (segment.isGlitch) {
                                      return WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GlitchText(
                                          text: segment.text,
                                          style: const TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      );
                                    }
                                    return TextSpan(text: segment.text);
                                  }).toList(),
                                ),
                              ),
                            ]
                          ),
                        )
                      ),
                    );
                  }
                ),
              ),
            ]
          );
        }
      ),
    );
  }
}