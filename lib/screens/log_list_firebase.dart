import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionamento/screens/log_card_firebase.dart';
import 'package:flutter/material.dart';
import '../models/record.dart';

class LogList extends StatefulWidget {
  const LogList({Key? key}) : super(key: key);

  @override
  State<LogList> createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  List<Object> _result = [];
  var _proprietario, _placa, _modelo, _destino, _hora, _data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRecordsFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _result.length,
          itemBuilder: (context, index) {
            return RecordCard(
              _result[index] as Record,
            );
          },
        ),
      ),
    );
  }


  Future getRecordsFirestore() async {
    var data = await FirebaseFirestore.instance
        .collection('log')
        .orderBy('createdAt', descending: false)
        .get();
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((element) {
    //     _proprietario = element['proprietario'];
    //     _placa = element['placa'];
    //     _modelo = element['modelo'];
    //     _destino = element['destino'];
    //     _hora = element['hora'];
    //     _data = element['data'];
    //     });
    // });

    setState(() {
      _result = List.from(data.docs.map((doc) => Record.fromSnapshot(doc)));
    });
  }
}
