import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double _tamanhoFonte = 18.0;

enum Destino { primeiro, bac, saida }

class NewRegisterForm extends StatefulWidget {
  @override
  State<NewRegisterForm> createState() => _NewRegisterFormState();
}

class _NewRegisterFormState extends State<NewRegisterForm> {
  var _placaDigitada = TextEditingController();
  var _modeloVeiculo = TextEditingController();
  var _proprietario = TextEditingController();
  var _dataDigitada = TextEditingController(
      text: DateFormat('dd/MM/yy').format(DateTime.now()));
  var _horaDigitada =
      TextEditingController(text: DateFormat('HH:mm').format(DateTime.now()));
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  List<Object> _result = [];

  Destino _destino = Destino.primeiro;
  var _destinoConv = "";
  var _tipo = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getVehicleFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registrar entrada/saída"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            padding: EdgeInsets.all(40),
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                // initialValue: 'Oie',
                // maxLength: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Placa",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      await getVehicleFromFirestore();
                    },
                  ),
                ),
                controller: _placaDigitada,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Minímo de 5 caracteres';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Veículo",
                  ),
                  controller: _modeloVeiculo,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Minímo de 5 caracteres';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Proprietário",
                  ),
                  controller: _proprietario,
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
                  textCapitalization: TextCapitalization.characters,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2023),
                            locale: Locale("pt", "BR"),
                          );

                          setState(() {
                            _dataDigitada.text =
                                DateFormat('dd/MM/yy').format(data!);
                          });
                        },
                      )),
                  controller: _dataDigitada,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Minímo de 5 caracteres';
                    }
                    return null;
                  },
                ),
              ),
              //ESCOLHA DA HORA
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hora',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time_outlined),
                        onPressed: () async {
                          final TimeOfDay? result = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (result != null) {
                            setState(() {
                              _horaDigitada.text = result.format(context);
                            });
                          }
                        },
                      )),
                  controller: _horaDigitada,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Minímo de 5 caracteres';
                    }
                    return null;
                  },
                ),
              ),
              // DIREÇÃO
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      value: Destino.primeiro,
                      groupValue: _destino,
                      onChanged: (Destino? destinoRadio) {
                        setState(() {
                          _destino = destinoRadio!;
                        });
                      },
                    ),
                    Text(
                      "1º BPM",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: _tamanhoFonte,
                      ),
                    ),
                    Radio(
                      value: Destino.bac,
                      groupValue: _destino,
                      onChanged: (Destino? destinoRadio) {
                        setState(() {
                          _destino = destinoRadio!;
                        });
                      },
                    ),
                    Text(
                      "BAC",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: _tamanhoFonte,
                      ),
                    ),
                    Radio(
                      value: Destino.saida,
                      groupValue: _destino,
                      onChanged: (Destino? destinoRadio) {
                        setState(() {
                          _destino = destinoRadio!;
                        });
                      },
                    ),
                    Text(
                      "Saída",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: _tamanhoFonte,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () async {
                    if (_destino == Destino.primeiro) {
                      _destinoConv = "1ºBPM";
                    } else if (_destino == Destino.bac) {
                      _destinoConv = "BAC";
                    } else {
                      _destinoConv = "SAÍDA";
                    }

                    if (!_formKey.currentState!.validate()) {
                      setState(() => _autoValidate = AutovalidateMode.disabled);
                    } else {
                      print(
                          '\n ${_proprietario.text} / ${_placaDigitada.text} / ${_modeloVeiculo.text} / ${_destinoConv} / '
                          '${_dataDigitada.text} / ${_horaDigitada.text} ');

                      Map<String, dynamic> newRecord = {
                        "proprietario": _proprietario.text,
                        "placa": _placaDigitada.text,
                        "modelo": _modeloVeiculo.text,
                        "destino": _destinoConv,
                        "data": _dataDigitada.text,
                        "hora": _horaDigitada.text,
                        "createdAt": DateTime.now(),
                        "tipo": _tipo,
                      };

                      FirebaseFirestore.instance
                          .collection("log")
                          .add(newRecord);

                      // _daoRecord
                      //     .save(newRecord)
                      //     .then((id) => Navigator.pop(context, newRecord));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tudo certo, registro salvo!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context, newRecord);
                    }
                    ;
                  },
                  child: Text("Enviar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getVehicleFromFirestore() async {
    var data = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('placa', isEqualTo: _placaDigitada.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        _modeloVeiculo.text = element['modelo'];
        _proprietario.text = element['proprietario'];
        _tipo = element['tipo'];
      });
    });
  }
}
