import 'package:flutter/material.dart';

import '../models/vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle _vehicle;
  const VehicleCard(this._vehicle);


  @override
  Widget build(BuildContext context) {
    IconData tipoVeiculo;
    if (_vehicle.tipo == 'moto') {
      tipoVeiculo = Icons.motorcycle_outlined;
    } else {
      tipoVeiculo = Icons.drive_eta_outlined;
    }

    return Card(
      child: ListTile(
        leading: Icon(
          tipoVeiculo,
          size: 40,
          color: Colors.black,
        ),
        title: Text('${_vehicle.placa}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_vehicle.modelo}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              '${_vehicle.proprietario}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }
}