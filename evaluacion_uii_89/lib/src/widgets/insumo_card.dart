import 'package:evaluacion_uii_89/src/models/insumo_model.dart';
import 'package:flutter/material.dart';

class InsumoCard extends StatelessWidget {
  const InsumoCard({Key? key, required this.model}) : super(key: key);
  final Insumo model;

  @override
  Widget build(BuildContext context) {
    final icon = model.tipo == 0
        ? const Icon(Icons.build_circle)
        : model.tipo == 1
            ? const Icon(Icons.cable)
            : const Icon(Icons.light);

    return Card(
        child: ListTile(
            trailing: icon,
            leading: Text(model.id.toString()),
            title: Text(model.nombre),
            subtitle: Text(model.descripcion)));
  }
}