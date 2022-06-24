import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String proprietario;
  String placa;
  String modelo;
  String destino;
  String data;
  String hora;
  Timestamp createdAt;
  String tipo;

  Record(this.proprietario, this.placa, this.modelo, this.destino, this.data,
      this.hora, this.createdAt, this.tipo);

  Map<String, dynamic> toJson() => {
        'proprietario': proprietario,
        'placa': placa,
        'modelo': modelo,
        'destino': destino,
        'data': data,
        'hora': hora,
        'createdAt': createdAt,
        'tipo': tipo
      };

  Record.fromSnapshot(snapshot)
      : proprietario = snapshot.data()['proprietario'],
        placa = snapshot.data()['placa'],
        modelo = snapshot.data()['modelo'],
        destino = snapshot.data()['destino'],
        data = snapshot.data()['data'],
        hora = snapshot.data()['hora'],
        createdAt = snapshot.data()['createdAt'],
        tipo = snapshot.data()['tipo'] ?? 'carro';
}
