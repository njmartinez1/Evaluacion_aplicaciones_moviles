import 'package:evaluacion_uii_89/src/models/insumo_model.dart';
import 'package:evaluacion_uii_89/src/pages/insumo_form_pages.dart';
import 'package:evaluacion_uii_89/src/providers/insumo_provider.dart';
import 'package:evaluacion_uii_89/src/widgets/insumo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InsumoListWidget extends StatelessWidget {
  const InsumoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialProvider = Provider.of<InsumoProvider>(context, listen: true);
    return FutureBuilder<List<Insumo>>(
        future: materialProvider.loadElements(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: SizedBox.square(
                    dimension: 50.0, child: Text("Un error ha ocurrido")));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox.square(
                  dimension: 50.0, child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: snapshot.data!.isEmpty
                ? const Center(
                    child: SizedBox.square(
                        dimension: 150.0,
                        child: Text("No hay datos en el SQLite")))
                : ListView(
                    children: snapshot.data!
                        .map((e) => InsumoCard(model: e))
                        .toList(),
                  ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const InsumoFormPage(),
                    ),
                  );
                },
                child: const Icon(Icons.add)),
          );
        });
  }
}