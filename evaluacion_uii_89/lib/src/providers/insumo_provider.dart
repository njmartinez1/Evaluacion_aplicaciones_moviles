import 'package:evaluacion_uii_89/src/models/insumo_model.dart';
import 'package:evaluacion_uii_89/src/providers/db_provider.dart';
import 'package:flutter/cupertino.dart';

class InsumoProvider extends ChangeNotifier {
  List<Insumo> elements = [];

  Future<Insumo> addElement(Insumo model) async {
    final id = await DBProvider.dbProvider.insert(model);
    model.id = id;
    elements.add(model);
    notifyListeners();
    return model;
  }

  Future<List<Insumo>> loadElements() async {
    elements = await DBProvider.dbProvider.list();
    return elements;
  }
}