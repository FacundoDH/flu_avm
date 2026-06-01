import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration visibleDuration;
  final Duration glitchDuration;
  final Duration glitchSpeed;

  const GlitchText({
    super.key,
    required this.text,
    this.style,
    this.visibleDuration = const Duration(seconds: 2),
    this.glitchDuration = const Duration(seconds: 3),
    this.glitchSpeed = const Duration(milliseconds: 50),
  });

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> {
  
  static const String _chars =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#[+=€-_{}Ç%&*?';

  final Random _random = Random();
  late String _displayText;
  Timer? _cycleTimer;
  Timer? _glitchTimer;

  @override
  void initState() {
    super.initState();
    _displayText = widget.text;
    _startVisible();
  }

  void _startVisible() {
    _cycleTimer = Timer(widget.visibleDuration, _startGlitch);
  }

  void _startGlitch() {
    _glitchTimer = Timer.periodic(widget.glitchSpeed, (_) {
      setState(() {
        _displayText = widget.text.split('').map((char) {
          if (char == ' ') return ' ';
          return _chars[_random.nextInt(_chars.length)];
        }).join();
      });
    });

    _cycleTimer = Timer(widget.glitchDuration, () {
      _glitchTimer?.cancel();
      setState(() => _displayText = widget.text);
      _startVisible();
    });
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _glitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayText, style: widget.style,);
  }
}