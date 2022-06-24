// import 'package:estacionamento/database/dao/record_dao.dart';
// import 'package:estacionamento/database/dao/vehicle_dao.dart';
// import 'package:estacionamento/models/vehicle.dart';
// import 'package:estacionamento/screens/add_vehicle_form.dart';
// import 'package:flutter/material.dart';
//
// class VehiclesList extends StatefulWidget {
//   @override
//   State<VehiclesList> createState() => _VehiclesListState();
// }
//
// class _VehiclesListState extends State<VehiclesList> {
//   final VehicleDao _dao = VehicleDao();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Veículos Cadastrados'),
//       ),
//       body: FutureBuilder<List<Vehicle>>(
//         initialData: [],
//         future: _dao.getCollection(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               break;
//             case ConnectionState.waiting:
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [CircularProgressIndicator(), Text('Carregando')],
//                 ),
//               );
//               break;
//             case ConnectionState.active:
//               break;
//             case ConnectionState.done:
//               final List<Vehicle> vehicles = snapshot.data!;
//               return ListView.builder(
//                 itemBuilder: (context, index) {
//                   final Vehicle vehicle = vehicles[index];
//                   return _VehicleItem(vehicle);
//                 },
//                 itemCount: vehicles.length,
//               );
//               break;
//           }
//           return Text('Erro desconhecido');
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Navigator.of(context)
//       //         .push(
//       //       MaterialPageRoute(
//       //         builder: (context) => AddVehicleForm(),
//       //       ),
//       //     )
//       //         .then(
//       //           (value) => setState(() {}),
//       //     );
//       //   },
//       //   child: Icon(
//       //     Icons.add,
//       //   ),
//       // ),
//     );
//   }
// }
//
// class _VehicleItem extends StatefulWidget {
//   final Vehicle vehicle;
//
//   _VehicleItem(this.vehicle);
//
//   @override
//   State<_VehicleItem> createState() => _VehicleItemState();
// }
//
// class _VehicleItemState extends State<_VehicleItem> {
//   @override
//   Widget build(BuildContext context) {
//     IconData tipoVeiculo;
//     if (widget.vehicle.tipo == 'moto') {
//         tipoVeiculo = Icons.motorcycle_outlined;
//     }else{
//       tipoVeiculo = Icons.drive_eta_outlined;
//     }
//
//     return Card(
//       child: ListTile(
//         leading: Icon(
//           tipoVeiculo,
//           size: 40,
//           color: Colors.black,
//         ),
//         title: Text(
//           widget.vehicle.placa,
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.vehicle.modelo,
//               style: TextStyle(
//                 fontSize: 18.0,
//               ),
//             ),
//             Text(
//               widget.vehicle.proprietario,
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ],
//         ),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         contentPadding: EdgeInsets.all(10.0),
//       ),
//     );
//   }
// }
