//state providers sirven para guardar pequeñas informaciones de estado para nuestra app, variables numericas, booleanas, etc
import 'package:flutter_riverpod/legacy.dart';

final numeratorProvider = StateProvider((ref) => 5); //variable con el valor de 5, ref -> mpspermite acceder a la variable