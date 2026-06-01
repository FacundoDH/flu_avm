import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';


class TextSegment {
  final String text;
  final bool isGlitch;

  const TextSegment(
    this.text,
    {this.isGlitch = false});
}

class Scene {
  final Color color;
  final String title;
  final List<TextSegment> body;
  final Alignment alignment;

  const Scene({
    required this.color,
    required this.title,
    required this.body,
    this.alignment = Alignment.center,
  });
}

const List<Scene> scenes = [
  Scene(
    color: Colors.black,
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment(' Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.bottomLeft,
  ),
  Scene(
    color: Colors.red,
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment(' Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.center,
  ),
  Scene(
    color: Colors.white,
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.topRight,
  ),
  Scene(
    color: Colors.green,
    title: 'Placeholder',
    body: [
      TextSegment('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida.'),
      TextSegment('Quisque ac auctor ante, eget dapibus neque.', isGlitch: true), 
      TextSegment('Interdum et malesuada fames ac ante ipsum primis in faucibus.'),
      ],
    alignment: Alignment.topLeft,
  ),
  Scene(
    color: Colors.purple,
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [

              Positioned.fill(child: Container(color: scenes[_currentScene].color),
              ),

              Positioned.fill(
                child: Opacity(
                  opacity: _fadeProgress,
                  child: Container(color: scenes[nextScene].color),
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
                          color: Colors.white.withValues(alpha: 0.5),
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
                                  color: Colors.black,
                                  letterSpacing: 4,
                                ),
                              ),
                          
                              SizedBox(height:10),
                          
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 14,
                                    color: Colors.black,
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
                                            color: Colors.black,
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