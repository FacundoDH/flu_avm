import 'dart:math' as math;

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flu AVM App'),
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override

  Widget build(BuildContext context) {
    return ListView.builder( //lista
    itemCount: 7,
      itemBuilder:(context, index) { //actua como un for para a lista
        return ListTile(
          title: _MyListTile(),
        );
      },
    );
  }
}

class _MyListTile extends StatelessWidget {
  const _MyListTile();

  @override

  Widget build(BuildContext context) {

    final colorum = Theme.of(context).colorScheme;

    return ListTile(  //Elementos de la lista
      title: Text('Contador'),
      subtitle: Text('Introducción a Riverpod'),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colorum.primary,),
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(
        100, 
        math.Random().nextInt(255), 
        math.Random().nextInt(255), 
        math.Random().nextInt(255)
        ),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      onTap: () { }, //"al pulsar"
    );
  }
}
