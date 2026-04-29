import 'dart:math' as math;

import 'package:flu_avm/config/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      itemCount: appMenuItems.length,
      itemBuilder:(context, index) { //actua como un for para a lista
        final menuItem = appMenuItems[index];
        return _MyListTile(menuItem: menuItem);
      },
    );
  }
}

class _MyListTile extends StatelessWidget {

  final MenuItem menuItem; //llamamos la lista de menu item

  const _MyListTile({
    required this.menuItem
  });

  @override

  Widget build(BuildContext context) {

    final colorum = Theme.of(context).colorScheme;

    return ListTile(  //Elementos de la lista
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subtitle),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colorum.primary,),
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(
        100, 
        math.Random().nextInt(255), 
        math.Random().nextInt(255), 
        math.Random().nextInt(255)
        ),
        child: Icon(
          menuItem.icon,
          color: Colors.black,
        ),
      ),
      onTap: () {
        context.push(menuItem.link);
      }, //"al pulsar"
    );
  }
}
