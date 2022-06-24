import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Record> _result = [];
  var _dataDigitada = TextEditingController(
      text: DateFormat('dd/MM/yy').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    getRecordsFirestore();

    return Scaffold(
      appBar: AppBar(
        title: Text('Exportar registros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Escolha a data de início:'),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2023),
                            locale: Locale("pt", "BR"),
                          );

                          setState(() {
                            _dataDigitada.text =
                                DateFormat('dd/MM/yy').format(data!);
                          });
                        },
                      )),
                  controller: _dataDigitada,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Minímo de 5 caracteres';
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
    );
  }

  Future<void> createExcel() async{
    // getRecordsFirestore();

    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1:A100').cellStyle.bold = true;
    sheet.getRangeByName('C1:C100').cellStyle.bold = true;
    sheet.getRangeByName('E1:E100').cellStyle.bold = true;
    sheet.getRangeByName('G1:G100').cellStyle.bold = true;
    sheet.getRangeByName('I1:I100').cellStyle.bold = true;

    sheet.getRangeByName('A3').setText('Início:', );
    sheet.getRangeByName('B3').setText(_dataDigitada.text);

    for(int i = 0; i < _result.length; i++){
      sheet.getRangeByName('A${i+5}').setText('Nome:', );
      sheet.getRangeByName('B${i+5}').setText('${_result[i].proprietario}');
      sheet.getRangeByName('C${i+5}').setText('Placa/Prefixo:');
      sheet.getRangeByName('D${i+5}').setText('${_result[i].placa}');
      sheet.getRangeByName('E${i+5}').setText('Modelo:');
      sheet.getRangeByName('F${i+5}').setText('${_result[i].modelo}');
      sheet.getRangeByName('G${i+5}').setText('Destino:');
      sheet.getRangeByName('H${i+5}').setText('${_result[i].destino}');
      sheet.getRangeByName('I${i+5}').setText('Hora:');
      sheet.getRangeByName('J${i+5}').setText('${_result[i].hora}');

    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Relatório.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  Future<void> getRecordsFirestore() async{
    var data = await FirebaseFirestore.instance
        .collection("log")
        .where("data", isGreaterThanOrEqualTo: _dataDigitada.text)
        .orderBy("data", descending: false)
        .get();

      _result = List.from(data.docs.map((doc) => Record.fromSnapshot(doc)));
  }
}
