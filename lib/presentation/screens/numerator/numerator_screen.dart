import 'package:flutter/material.dart';

class NumeratorScreen extends StatefulWidget {
  const NumeratorScreen ({super.key});

  @override
  State<NumeratorScreen> createState() => NumeratorScreenState();
}

class NumeratorScreenState extends State<NumeratorScreen> {

  int counter = 0; //variable del contador que uniremos a 'valor'

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numerator Screen'),
      ),
      body: Center(
        child: Text('Valor: $counter', style: Theme.of(context).textTheme.titleLarge,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        }, //usamos esto para incrementar 'counter'
        child: Icon(Icons.add),
      ),
    );
  }
}