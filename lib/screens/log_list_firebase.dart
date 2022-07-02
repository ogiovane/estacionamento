import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionamento/screens/log_card_firebase.dart';
import 'package:flutter/material.dart';
import '../models/record.dart';

class LogList extends StatefulWidget {
  @override
  State<LogList> createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  List<Object> _result = [];

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
    var now = DateTime.now().subtract(Duration(days: 1));
    var nowTimestamp = Timestamp.fromDate(now);
    return nowTimestamp;
  }

  Future getRecordsFirestore() async {
    var date1 = DateTime.now();
    var data = await FirebaseFirestore.instance
        .collection("log")
        .where("dateTime", isGreaterThanOrEqualTo: getStartOfToday())
        .orderBy("dateTime", descending: false)
        .get();

    setState(() {
      _result = List.from(data.docs.map((doc) => Record.fromSnapshot(doc)));
    });
  }
}
