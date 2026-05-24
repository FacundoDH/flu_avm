import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: PokemonsVisual()
    );
  }
}

class PokemonsVisual extends ConsumerStatefulWidget {
  const PokemonsVisual({super.key});

  @override

  ConsumerState<PokemonsVisual> createState() => _PokemonsVisualState();
}

class _PokemonsVisualState extends ConsumerState<PokemonsVisual> {

  bool isLoading = false;

  final scrollController = ScrollController();

  @override
  void initState() {
    
    scrollController.addListener(() {

      if (scrollController.position.pixels + 200 > scrollController.position.maxScrollExtent) {
        addNextPage();

      }
    });

    super.initState();
  }

  @override

  void dispose() {
    
    scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return CustomScrollView (
      controller: scrollController,
      slivers: [
        SliverAppBar(
            floating: true,
            title: Text('Pokemons'),
            backgroundColor: Theme.of(context).secondaryHeaderColor.withValues(alpha: 0.5),
        ),
        _PokemonGrid()
      ],
    );
  }

  Future addNextPage() async {

    if(isLoading) return;

    isLoading = true;

    await Future.delayed(const Duration(seconds: 2));

    ref.read(pokemonIdsProvider.notifier).update((state) => [
      ...state,
      ...List.generate(30, (index) => state.length + index + 1)
    ]);

    isLoading = false;

    moveScrollDescend();
  }

  void moveScrollDescend() {
    if (scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;

    scrollController.animateTo(
      scrollController.position.pixels + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn
    );
  }
}

class _PokemonGrid extends ConsumerWidget {

  const _PokemonGrid();

  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final pokemonIds = ref.watch(pokemonIdsProvider);

    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemonIds.length,
      itemBuilder:(context, index) {
        return GestureDetector(
          onTap: () {
            context.push('/request/${index + 1}');
          },
          child: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png', fit: BoxFit.contain)
        );
      },
    );
  }
}