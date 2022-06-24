import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionamento/screens/vehicle_card_firebase.dart';
import 'package:flutter/material.dart';
import '../models/vehicle.dart';

class VehiclesListFirebase extends StatefulWidget {
  const VehiclesListFirebase({Key? key}) : super(key: key);

  @override
  State<VehiclesListFirebase> createState() => _VehiclesListFirebaseState();
}

class _VehiclesListFirebaseState extends State<VehiclesListFirebase> {
  List<Object> _result = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Veículos cadastrados'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _result.length,
          itemBuilder: (context, index) {
            return VehicleCard(
              _result[index] as Vehicle,
            );
          },
        ),
      ),
    );
  }

  Future getRecords() async {
    var data = await FirebaseFirestore.instance.collection('vehicles').orderBy('placa', descending: false).get();

    setState(() {
      _result = List.from(data.docs.map((doc) => Vehicle.fromSnapshot(doc)));
    });
  }
}
