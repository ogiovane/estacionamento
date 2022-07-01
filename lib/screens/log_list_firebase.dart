import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionamento/screens/log_card_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/record.dart';

class LogList extends StatefulWidget {
  const LogList({Key? key}) : super(key: key);

  @override
  State<LogList> createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  List<Object> _result = [];
  final _dataDigitada = DateFormat('dd/MM/yy').format(DateTime.now());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRecordsFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros do dia'),
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

  getStartOfToday() {
    var now = DateTime.now();
    var nowTimestamp = Timestamp.fromDate(now);
    return nowTimestamp;
  }

  Future getRecordsFirestore() async {
    var date1 = DateTime.now();
    // print('DATA DIGITADA = ${_dataDigitada}');
    var data = await FirebaseFirestore.instance
        .collection("log")
        .where("dateTime", isGreaterThanOrEqualTo: getStartOfToday())
        .orderBy("dateTime", descending: false)
        .get();

    print('TAMANHO DO RESULTADO = ${data.size}');

    setState(() {
      _result = List.from(data.docs.map((doc) => Record.fromSnapshot(doc)));
    });
  }
}
