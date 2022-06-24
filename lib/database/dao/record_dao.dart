// import 'package:sqflite/sqflite.dart';
// import 'package:estacionamento/models/record.dart';
// import 'package:estacionamento/database/app_database.dart';
//
// class RecordDao {
//   static const String tableSql = 'CREATE TABLE $_tableName('
//       '$_id INTEGER PRIMARY KEY, '
//       '$_proprietario TEXT,'
//       '$_placa TEXT, '
//       '$_modelo TEXT, '
//       '$_destino TEXT, '
//       '$_data TEXT, '
//       '$_hora TEXT)';
//
//   static const String _tableName = 'records';
//   static const _id = 'id';
//   static const String _proprietario = 'proprietario';
//   static const String _placa = 'placa';
//   static const String _modelo = 'modelo';
//   static const String _destino = 'destino';
//   static const String _data = 'data';
//   static const String _hora = 'hora';
//
//
//   Future<int> save(Record record) async {
//     final Database db = await getRecordsDatabase();
//     Map<String, dynamic> recordMap = _toMap(record);
//     print("REGISTRO SALVO");
//     return db.insert(_tableName, recordMap);
//   }
//
//   Map<String, dynamic> _toMap(Record record) {
//     final Map<String, dynamic> recordMap = {};
//     recordMap[_proprietario] = record.proprietario;
//     recordMap[_placa] = record.placa;
//     recordMap[_modelo] = record.modelo;
//     recordMap[_destino] = record.destino;
//     recordMap[_data] = record.data;
//     recordMap[_hora] = record.hora;
//
//     return recordMap;
//   }
//
//
//   Future<List<Record>> findAll() async {
//     final Database db = await getRecordsDatabase();
//     final List<Map<String, dynamic>> result = await db.query(_tableName);
//     List<Record> records = _toList(result);
//     print("REGISTROS BUSCADOS");
//     return records;
//   }
//
//   List<Record> _toList(List<Map<String, dynamic>> result) {
//     final List<Record> records = [];
//     for (Map<String, dynamic> row in result) {
//       final Record record = Record(
//         row[_id],
//         row[_proprietario],
//         row[_placa],
//         row[_modelo],
//         row[_destino],
//         row[_data],
//         row[_hora],
//       );
//       records.add(record);
//     }
//     return records;
//   }
//
//   // findOne(placaDigitada) async {
//   //   print('FUNÇÃO PLACA RECEBIDA CHAMADA');
//   //   // get a reference to the database
//   //   final Database db = await getDatabase();
//   //   // get single row
//   //   List<String> columnsToSelect = [
//   //     VehicleDao._placa,
//   //     VehicleDao._modelo,
//   //     VehicleDao._proprietario,
//   //   ];
//   //   String whereString = '${VehicleDao._placa} = ?';
//   //   String placa = placaDigitada;
//   //   print('STRING PLACA = ' + placa);
//   //   List<dynamic> whereArguments = [placa];
//   //   List<Map> result = await db.query(
//   //       VehicleDao._tableName,
//   //       columns: columnsToSelect,
//   //       where: whereString,
//   //       whereArgs: whereArguments);
//   //   // print the results
//   //   // result.forEach((row) => print(row));
//   //   // {_id: 1, name: Bob, age: 23}
//   //   return result;
//   // }
//
// }
