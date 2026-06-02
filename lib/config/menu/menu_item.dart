import 'package:flutter/material.dart';

class MenuItem {  //Elementos de los cajones
  final String title; //titulo del cajón
  final String subtitle; //subtitulo cajón
  final String link; //ruta a la que vamos a viajar
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.icon
  });
}

const appMenuItems = <MenuItem>[ //lista de objetos de tipo MenuItems
  MenuItem(
    title: 'Contador',
    subtitle: 'Introducción a Riverpod',
    link: '/numerator-river',
    icon: Icons.add
    ),
  MenuItem(
    title: 'Bandas musicales',
    subtitle: 'Gráficos Pie Char y votaciones',
    link: '/bands',
    icon: Icons.music_note_outlined
    ),
  MenuItem(
    title: 'Mapas',
    subtitle: 'Localización de usuarios',
    link: '/charts',
    icon: Icons.map_outlined
  ),
  MenuItem(
    title: 'PokeApi',
    subtitle: 'Peticiones http a una API',
    link: '/request',
    icon: Icons.catching_pokemon
  ),
  MenuItem(
    title: 'Abu Ghraib',
    subtitle: '_ERROR_RIGHTS: (NOT FOUND)',
    link: '/personal',
    icon: Icons.person_outline,
  ),
];