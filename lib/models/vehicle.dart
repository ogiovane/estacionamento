class Vehicle {
  String? placa;
  String? modelo;
  String? proprietario;
  String? tipo;


  Vehicle(this.placa, this.modelo, this.proprietario, this.tipo);

  Map<String, dynamic> toJson() =>
      {'modelo': modelo, 'placa': placa,
        'proprietario': proprietario, 'tipo': tipo};

  Vehicle.fromSnapshot(snapshot)
      : placa = snapshot.data()['placa'],
        modelo = snapshot.data()['modelo'],
        proprietario = snapshot.data()['proprietario'],
        tipo = snapshot.data()['tipo'];

}