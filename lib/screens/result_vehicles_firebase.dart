import 'package:flutter/material.dart';

import '../models/vehicle.dart';

class ResultFirebase extends StatelessWidget {
  final Vehicle _vehicle;

  ResultFirebase(this._vehicle);

  @override
  Widget build(BuildContext context) {
        return Text('${_vehicle.placa} / ${_vehicle.modelo} / ${_vehicle.proprietario}');
}
}