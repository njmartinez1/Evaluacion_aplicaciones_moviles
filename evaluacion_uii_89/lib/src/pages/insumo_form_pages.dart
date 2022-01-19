import 'package:evaluacion_uii_89/src/models/insumo_model.dart';
import 'package:evaluacion_uii_89/src/providers/insumo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InsumoFormPage extends StatefulWidget {
  const InsumoFormPage({Key? key}) : super(key: key);

  @override
  _InsumoFormPageState createState() => _InsumoFormPageState();
}

class _InsumoFormPageState extends State<InsumoFormPage> {
  final _formKey = GlobalKey<FormState>();
  late Insumo _model;
  bool _onSaving = false;
  //Atributos utilizados en la selección
  final List<String> _typesElement = ['Herramientas', 'Insumos', 'Materiales'];
  String _typeSelected = "Herramientas";

  @override
  void initState() {
    super.initState();
    _model = Insumo.created();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final insumoProvider = Provider.of<InsumoProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: const Text("Nuevo registro")),
      body: SingleChildScrollView(
          child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ])),
          ),
          Column(
            children: [
              //SizedBox.square(dimension: 120.h),
              Text("Registro de uso",
                  style: Theme.of(context).textTheme.headline5),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 14.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: size.width * .80,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 2.0, color: Theme.of(context).primaryColorDark)),
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 7.0),
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            value: _typeSelected,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            underline: Container(height: 2),
                            onChanged: (String? newValue) {
                              _model.tipo = _typesElement.indexOf(newValue!);
                              setState(() {
                                _typeSelected = newValue;
                              });
                            },
                            items: _typesElement
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _model.nombre,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                                _model.nombre = value.toString();
                              },
                              validator: (value) {
                                return _validateNombre(value!);
                              },
                              decoration:
                                  const InputDecoration(labelText: "Nombre"),
                              maxLength: 50),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _model.descripcion,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                                _model.descripcion = value.toString();
                              },
                              validator: (value) {
                                return _validateObservacion(value!);
                              },
                              decoration: const InputDecoration(
                                  labelText: "Descripción"),
                              maxLength: 255,
                              maxLines: 3),
                          _onSaving
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Tooltip(
                                    message: "Registrar insumo utilizado",
                                    child: ElevatedButton.icon(
                                        onPressed: () async {
                                          if (!_formKey.currentState!
                                              .validate()) return;
                                          _onSaving = true;
                                          setState(() {});

                                          //Vincula el valor de las controles del formulario a los atributos del modelo
                                          _formKey.currentState!.save();

                                          _model = await insumoProvider
                                              .addElement(_model);
                                          if (_model.id != null) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        label: const Text("Guardar"),
                                        icon: const Icon(Icons.save)),
                                  ),
                                )
                        ],
                      ),
                    )),
              )
            ],
          ),
        ],
      )),
    );
  }

  String? _validateObservacion(String value) {
    return (value.length < 15)
        ? "Debe ingresar una observación con al menos 15 caracteres"
        : null; //Validación se cumple al retorna null
  }

  String? _validateNombre(String value) {
    return (value.length < 10)
        ? "Debe ingresar un nombre con al menos 10 caracteres"
        : null; //Validación se cumple al retorna null
  }
}