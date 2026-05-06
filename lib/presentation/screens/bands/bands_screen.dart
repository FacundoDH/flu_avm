import 'package:flu_avm/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BandsScreen extends StatelessWidget {
  const BandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas'),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder:(context, i) {
          return _bandTile(bands[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1, //sombra del elemento, diseño
        onPressed: () => addNewBand(context),
        child: Icon(Icons.add),
      )
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id), //necesario en los dismissibles, se necesita para que sepa que elemento borrar y poder cambiar el índice
      direction: DismissDirection.startToEnd, //izquierda a derecha
      onDismissed:(direction) {
        print('Direction: $direction');
        print('id: ${band.id}');
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
          print(band.name);
        },
      ),
    );
  }

  addNewBand(BuildContext context) {

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
              addBandToList(context, textController.text);
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

  void addBandToList(BuildContext context, String name) {
    print(name);
    context.pop();
  }
}

