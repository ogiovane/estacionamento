// import 'package:estacionamento/database/dao/vehicle_dao.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import 'package:estacionamento/models/vehicle.dart';
//
// import 'dao/record_dao.dart';
//
// Future<Database> "getDatabase"() async {
//   final String path = join(await getDatabasesPath(), 'estacionamento.db');
//   return openDatabase(
//     path,
//     onCreate: (db, version) {
//       db.execute(VehicleDao.tableSql);
//     },
//     version: 1,
//     // onDowngrade: onDatabaseDowngradeDelete,
//   );
// }
//
// Future<Database> getRecordsDatabase() async {
//   final String path = join(await getDatabasesPath(), 'records.db');
//   return openDatabase(
//     path,
//     onCreate: (db, version) {
//       db.execute(RecordDao.tableSql);
//     },
//     version: 1,
//     // onDowngrade: onDatabaseDowngradeDelete,
//   );
// }
//
