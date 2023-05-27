import 'package:flutter/material.dart';
import 'dart:convert';

// QR Code Result Page
class QRCodeResultPage extends StatelessWidget {
  final String qrCodeData;

  const QRCodeResultPage(this.qrCodeData);

  @override
  Widget build(BuildContext context) {
    final jsonMap = jsonDecode(qrCodeData);

    final tableRows = <TableRow>[];
    jsonMap.forEach((key, value) {
      tableRows.add(TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                key.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(value.toString()),
            ),
          ),
        ],
      ));
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // body: Center(
      //   child: Text(
      //     qrCodeData,
      //     style: TextStyle(fontSize: 24),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Paitent Information',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Table(
                  border: TableBorder.all(),
                  children: tableRows,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
