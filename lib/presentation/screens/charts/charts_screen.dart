import 'package:flu_avm/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChartsScreen extends StatefulWidget {

  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();

}

class _ChartsScreenState extends State<ChartsScreen> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                'Mapa a pantalla completa',
                style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: CompleteForm()
            ),
          )
        ]
      )
    );
  }
}