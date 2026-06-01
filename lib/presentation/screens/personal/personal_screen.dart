import 'package:flutter/material.dart';

class Scene {
  final Color color;
  final String title;
  final String body;

  const Scene({
    required this.color,
    required this.title,
    required this.body,
  });
}

const List<Scene> scenes = [
  Scene(
    color: Colors.black,
    title: 'Placeholder',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida. Quisque ac auctor ante, eget dapibus neque. Interdum et malesuada fames ac ante ipsum primis in faucibus.'
  ),
  Scene(
    color: Colors.red,
    title: 'Placeholder',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida. Quisque ac auctor ante, eget dapibus neque. Interdum et malesuada fames ac ante ipsum primis in faucibus.'
  ),
  Scene(
    color: Colors.white,
    title: 'Placeholder',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida. Quisque ac auctor ante, eget dapibus neque. Interdum et malesuada fames ac ante ipsum primis in faucibus.'
  ),
  Scene(
    color: Colors.green,
    title: 'Placeholder',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida. Quisque ac auctor ante, eget dapibus neque. Interdum et malesuada fames ac ante ipsum primis in faucibus.'
  ),
  Scene(
    color: Colors.purple,
    title: 'Placeholder',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec porta porttitor gravida. Quisque ac auctor ante, eget dapibus neque. Interdum et malesuada fames ac ante ipsum primis in faucibus.'
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
                    return SizedBox(height: constraints.maxHeight);
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