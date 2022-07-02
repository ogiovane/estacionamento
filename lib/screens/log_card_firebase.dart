import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/record.dart';

class RecordCard extends StatelessWidget {
  final Record _record;

  const RecordCard(this._record);

  @override
  Widget build(BuildContext context) {

     IconData tipoVeiculo;
    if (_record.tipo == 'moto') {
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
        title: Text(
          '${_record.placa}',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proprietário:\t ${_record.proprietario}\n'
              'Modelo:\t ${_record.modelo}\n'
              'Destino:\t ${_record.destino}\n'
                  'Data:\t ${DateFormat('dd/MM/yyyy - hh:mm').format(DateTime.fromMicrosecondsSinceEpoch(_record.dateTime.microsecondsSinceEpoch))}h',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }
}
