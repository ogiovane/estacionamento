import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionamento/models/vehicle.dart';
import 'package:flutter/material.dart';

double _tamanhoFonte = 18.0;

enum TipoVeiculo { carro, moto }

class AddVehicleForm extends StatefulWidget {
  @override
  State<AddVehicleForm> createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _placaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _proprietarioController = TextEditingController();
  TipoVeiculo _tipoVeiculo = TipoVeiculo.carro;
  String _tipoVeiculoConv = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar veículo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placa
                  TextFormField(
                    autofocus: true,
                    controller: _placaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Placa',
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (String? value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Minímo de 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: _modeloController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Modelo',
                      ),
                      textCapitalization: TextCapitalization.characters,
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Minímo de 5 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: _proprietarioController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Proprietário',
                      ),
                      textCapitalization: TextCapitalization.characters,
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Minímo de 5 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tipo:'),
                        Radio(
                          value: TipoVeiculo.carro,
                          groupValue: _tipoVeiculo,
                          onChanged: (TipoVeiculo? tipoVeiculo) {
                            setState(() {
                              _tipoVeiculo = tipoVeiculo!;
                            });
                          },
                        ),
                        Text(
                          "Carro",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: _tamanhoFonte,
                          ),
                        ),
                        Radio(
                          value: TipoVeiculo.moto,
                          groupValue: _tipoVeiculo,
                          onChanged: (TipoVeiculo? tipoVeiculo) {
                            setState(() {
                              _tipoVeiculo = tipoVeiculo!;
                            });
                          },
                        ),
                        Text(
                          "Moto",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: _tamanhoFonte,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_tipoVeiculo == TipoVeiculo.carro) {
                            _tipoVeiculoConv = "carro";
                          } else {
                            _tipoVeiculoConv = "moto";
                          }

                          if (!_formKey.currentState!.validate()) {
                            setState(() =>
                                _autoValidate = AutovalidateMode.disabled);
                          } else {
                            Map<String, dynamic> newVehicle = {
                              "placa": _placaController.text,
                              "modelo": _modeloController.text,
                              "proprietario": _proprietarioController.text,
                              "tipo": _tipoVeiculoConv,
                            };

                            FirebaseFirestore.instance
                                .collection("vehicles")
                                .add(newVehicle);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tudo certo, veículo salvo!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context, newVehicle);
                            print(
                                '${_placaController.text}, ${_proprietarioController.text}, ${_modeloController.text}, ${_tipoVeiculoConv}');
                          }
                          ;
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
