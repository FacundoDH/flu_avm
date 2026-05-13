import 'package:flu_avm/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';
import 'package:pie_chart/pie_chart.dart';

class BandsScreen extends ConsumerWidget {
  const BandsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bandsState = ref.watch(bandsProvider);

    final serverStatus = ref.watch(bandsProvider).serverStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (serverStatus == ServerStatus.Online)
              ? Icon(Icons.check_circle, color: Colors.blue[300],)
              : Icon(Icons.check_circle, color: Colors.red[300],),
          )
        ],
      ),

      body: Column(
        children: [
          //Grafico pie
          _videreData( bandsState.bands),
          const SizedBox(height: 20), //caja añadida para espaciar
          Expanded(
            child: ListView.builder(
              itemCount: bandsState.bands.length,
              itemBuilder:(context, i) {
                return _bandTile(context, ref, bandsState.bands[i]);
              },
            ),
          ),
        ],
      ),

      floatingActionButton: Visibility(
        visible: bandsState.bands.length < 7 ? true : false,
        child: FloatingActionButton(
          elevation: 1, //sombra del elemento, diseño
          onPressed: () => addNewBand(context, ref),
          child: Icon(Icons.add),
        ),
      )
    );
  }

  Widget _videreData( List<Band> bands ) {

    // ignore: prefer_collection_literals
  Map<String, double> dataMap = Map(); 

  for (var band in bands) { 
    dataMap.putIfAbsent(band.name, () => band.numberVotes.toDouble() );
  }

  final List<Color> colorList = [
    Colors.pink.shade100,
    Colors.pink.shade300,
    Colors.blue.shade200,
    Colors.blue.shade600,
    Colors.lightGreen.shade200,
    Colors.lightGreen.shade600,
  ];
  
  return dataMap.isNotEmpty ? Container(
    padding: const EdgeInsets.only(left: 5, top: 5),
    width: double.infinity,
    height: 200.0,
    child: PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      colorList: colorList,
      chartType: ChartType.ring,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "CupertinoSystemText", fontSize: 17,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValues: dataMap.length <= 6, // con más de 6 no se ve el valor
        showChartValueBackground: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
      ),
    ),
  ) : const LinearProgressIndicator();
}

  Widget _bandTile(BuildContext contex, WidgetRef ref, Band band) {
    return Dismissible(
      key: Key(band.id), //necesario en los dismissibles, se necesita para que sepa que elemento borrar y poder cambiar el índice
      direction: DismissDirection.startToEnd, //izquierda a derecha
      onDismissed:(direction) {
        ref.read(bandsProvider.notifier).deleteBand(band.id);
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
          ref.read(bandsProvider.notifier).addVote(band.id);
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
              //addBandToList(context, ref, textController.text);
              ref.read(bandsProvider.notifier).addBand(textController.text);
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

/*  void addBandToList(BuildContext context, WidgetRef ref, String name) {

    if (name.length > 1) {
      ref.read(bandsProvider.notifier).addBand(
        Band(
          id: DateTime.now().toString(),
          name: name,
          numberVotes: 0
          ));
    }
  } */
}

