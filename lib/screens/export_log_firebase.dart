import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../models/record.dart';

class ExportLog extends StatefulWidget {
  @override
  State<ExportLog> createState() => _ExportLogState();
}

class _ExportLogState extends State<ExportLog> {
  final formKey = GlobalKey<FormState>();
  List<Record> _result = [];
  var _dataDigitada = TextEditingController(
      text:
          '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year} - ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}h');

  DateTime dateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );

  @override
  Widget build(BuildContext context) {
    // getRecordsFirestore();

    return Scaffold(
      appBar: AppBar(
        title: Text('Exportar registros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Escolha a data e hora de início:', style: TextStyle(fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: 'Data',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            pickDateTime();

                          },
                        )),
                    controller: _dataDigitada,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Formato incorreto. Selecione pelo calendário';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green[700]),
                    child: Text('Exportar para Excel'),
                    onPressed: createExcel,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createExcel() async {
    await getRecordsFirestore();

    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1:A100').cellStyle.bold = true;
    sheet.getRangeByName('C1:C100').cellStyle.bold = true;
    sheet.getRangeByName('E1:E100').cellStyle.bold = true;
    sheet.getRangeByName('G1:G100').cellStyle.bold = true;
    sheet.getRangeByName('I1:I100').cellStyle.bold = true;

    sheet.getRangeByName('A3').setText('Início:');
    sheet.getRangeByName('B3').setText(_dataDigitada.text);

    for (int i = 0; i < _result.length; i++) {
      sheet.getRangeByName('A${i + 5}').setText('Nome:');
      sheet.getRangeByName('B${i + 5}').setText('${_result[i].proprietario}');
      sheet.getRangeByName('C${i + 5}').setText('Placa/Prefixo:');
      sheet.getRangeByName('D${i + 5}').setText('${_result[i].placa}');
      sheet.getRangeByName('E${i + 5}').setText('Modelo:');
      sheet.getRangeByName('F${i + 5}').setText('${_result[i].modelo}');
      sheet.getRangeByName('G${i + 5}').setText('Destino:');
      sheet.getRangeByName('H${i + 5}').setText('${_result[i].destino}');
      sheet.getRangeByName('I${i + 5}').setText('Hora:');
      sheet.getRangeByName('J${i + 5}').setText('${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(_result[i].dateTime.microsecondsSinceEpoch))}');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Relatório.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  Future<void> getRecordsFirestore() async {
    var timestamp = Timestamp.fromDate(dateTime);

    var data = await FirebaseFirestore.instance
        .collection("log")
        .where("dateTime", isGreaterThanOrEqualTo: timestamp)
        .orderBy("dateTime", descending: false)
        // .orderBy("hora", descending: false)
        .get();

    _result = List.from(data.docs.map((doc) => Record.fromSnapshot(doc)));

  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      dateTime = newDateTime;
      _dataDigitada.text =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} - ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}h';
    });

  }

  Future<DateTime?> pickDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      locale: Locale("pt", "BR"),
    );
  }

  Future<TimeOfDay?> pickTime() {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
}
