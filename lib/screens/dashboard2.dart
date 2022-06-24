import 'package:estacionamento/screens/add_vehicle_form.dart';
import 'package:estacionamento/screens/new_register_form.dart';

// import 'package:estacionamento/screens/log_list_firebase.dart';
import 'package:estacionamento/screens/log_list_firebase.dart';
import 'package:estacionamento/screens/under_maintence.dart';
import 'package:estacionamento/screens/vehicles_list_firebase.dart';
import 'package:flutter/material.dart';

import 'export_log_firebase.dart';
// import 'export_report.dart';

class Dashboard2 extends StatefulWidget {
  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  final _iconSize = 90.0;
  var options = [
    "Registrar entrada/saída",
    "Cadastrar veículo",
    "Listar cadastros",
    "Histórico",
    "Emitir relatório",
    "Desenvolvedor"
  ];

  var images = [
    Icons.playlist_add,
    Icons.add_circle_outline_sharp,
    Icons.featured_play_list_outlined,
    Icons.history,
    Icons.print,
    Icons.account_circle
  ];

  var tela = [
    NewRegisterForm(),
    AddVehicleForm(),
    VehiclesListFirebase(),
    LogList(),
    ExportLog(),
    UnderMaintence(),
  ];

  @override
  Widget build(BuildContext context) {
    final double alturaTela = (MediaQuery.of(context).size.height * 0.10);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Controle de Veículos v1.0"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, alturaTela, 10, 10),
        child: GridView.builder(
          itemCount: options.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkResponse(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      images[index],
                      size: _iconSize,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          // fontFamily: 'OpenSans',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => tela[index]));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
