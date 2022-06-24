import 'package:estacionamento/screens/add_vehicle_form.dart';
import 'package:estacionamento/screens/new_register_form.dart';
// import 'package:estacionamento/screens/log_list_firebase.dart';
import 'package:estacionamento/screens/vehicles_list_firebase.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _iconSize = 150.0;

  void _register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewRegisterForm()));
  }

  void _cadastro() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddVehicleForm()));
  }

  void _listarVeiculos() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VehiclesListFirebase()));
  }

  void _emitirRelatorio() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VehiclesListFirebase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Controle de Veículos"),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: _register,
                    child: Column(
                      children: [
                        Icon(
                          Icons.playlist_add,
                          size: _iconSize,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Registrar entrada/saída",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _cadastro,
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle_outline_sharp,
                          size: _iconSize,
                        ),
                        Text(
                          "Cadastrar veículo",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _listarVeiculos,
                    child: Column(
                      children: [
                        Icon(
                          Icons.featured_play_list_outlined,
                          size: _iconSize,
                        ),
                        Text(
                          "Listar cadastros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _emitirRelatorio,
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          size: _iconSize,
                        ),
                        Text(
                          "Histórico",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
