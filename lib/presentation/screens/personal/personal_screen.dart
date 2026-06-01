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
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment(' Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.center,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_3.jpg',
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.topRight,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_4.jpg',
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.topLeft,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_5.jpg',
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.bottomRight,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_6.jpg',
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.bottomRight,
  ),
  Scene(
    imagePath: 'assets/images/personal/personal_7.jpg',
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
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

    final int sceneIndex = (
      offset / screenHeight
    ).floor().clamp(0, scenes.length - 1);

    final double progress = (offset % screenHeight) / screenHeight;

    final double fadeProgress = progress < 0.7
      ? 0.0
      : ((progress - 0.7) / 0.3).clamp(0.0, 1.0);

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

    final int nextScene = (_currentScene + 1).clamp(0, scenes.length - 1);

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
                  itemCount: scenes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: constraints.maxHeight,
                      padding: EdgeInsets.symmetric(horizontal:32, vertical:64),
                      child: Align(
                        alignment: scenes[index].alignment,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.black.withValues(alpha: 0.8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          
                              Text(
                                scenes[index].title,
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
                                  children: scenes[index].body.map((segment) {
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