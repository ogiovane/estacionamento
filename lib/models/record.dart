import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String proprietario;
  String placa;
  String modelo;
  String destino;
  Timestamp dateTime;
  Timestamp createdAt;
  String tipo;

  Record(this.proprietario, this.placa, this.modelo, this.destino, this.dateTime, this.createdAt, this.tipo);

  Map<String, dynamic> toJson() => {
        'proprietario': proprietario,
        'placa': placa,
        'modelo': modelo,
        'destino': destino,
        'dateTime': dateTime,
        'createdAt': createdAt,
        'tipo': tipo
      };

  Record.fromSnapshot(snapshot)
      : proprietario = snapshot.data()['proprietario'],
        placa = snapshot.data()['placa'],
        modelo = snapshot.data()['modelo'],
        destino = snapshot.data()['destino'],
        dateTime = snapshot.data()['dateTime'],
        createdAt = snapshot.data()['createdAt'],
        tipo = snapshot.data()['tipo'] ?? 'carro';
}
