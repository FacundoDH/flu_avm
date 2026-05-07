import 'package:flu_avm/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class BandsScreen extends ConsumerWidget {
  const BandsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bands = ref.watch(bandsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas'),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder:(context, i) {
          return _bandTile(context, ref, bands[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1, //sombra del elemento, diseño
        onPressed: () => addNewBand(context, ref),
        child: Icon(Icons.add),
      )
    );
  }

  Widget _bandTile(BuildContext contex, WidgetRef ref, Band band) {
    return Dismissible(
      key: Key(band.id), //necesario en los dismissibles, se necesita para que sepa que elemento borrar y poder cambiar el índice
      direction: DismissDirection.startToEnd, //izquierda a derecha
      onDismissed:(direction) {
        ref.read(bandsProvider.notifier).deleteBand(band);
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2).toUpperCase()),
        ),
        title: Text(band.name),
        trailing: Text('${band.numberVotes}', style: TextStyle(fontSize: 20),),
        onTap: () {
          ref.read(bandsProvider.notifier).addVote(band);
        },
      ),
    );
  }

  addNewBand(BuildContext context, WidgetRef ref) {

    final TextEditingController textController = TextEditingController();

    
    /*showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('New band name'),
          content: TextField(controller: textController),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(context, textController.text), //llamamos a la función de añadir a lista y le damos el contexto y el textController
              textColor: Colors.blue,
              child: Text('Add'),
            )
          ],
        );
      },
    );*/

    showCupertinoDialog(
      context: context, 
      builder: ( BuildContext context ) => CupertinoAlertDialog(
        title: const Text('New band name'),
        content:  CupertinoTextField(
        controller: textController,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black
          )
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Add'),
            onPressed: () {
              addBandToList(context, ref, textController.text);
              context.pop();
            }
          ),
          CupertinoDialogAction(
            isDestructiveAction: true, //va a salir en rojo
            child: const Text('Close'),
            onPressed: () => context.pop()
          ),
        ],
      )
    );
  }

  void addBandToList(BuildContext context, WidgetRef ref, String name) {

    if (name.length > 1) {
      ref.read(bandsProvider.notifier).addBand(
        Band(
          id: DateTime.now().toString(),
          name: name,
          numberVotes: 0
          ));
    }
  }
}

