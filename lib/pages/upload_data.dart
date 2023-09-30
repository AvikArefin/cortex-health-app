import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cortex/urls/urlstring.dart';
import 'package:cortex/components/category_selection.dart';

// QR Code Result Page
typedef void SelectionCallback(String value1, String value2);

class QRCodeResultPage extends StatefulWidget {
  final String qrCodeData;
  const QRCodeResultPage(this.qrCodeData, {super.key});

  @override
  State<QRCodeResultPage> createState() => _QRCodeResultPageState();
}

class _QRCodeResultPageState extends State<QRCodeResultPage> {
  String disease = '', type = '';

  void handleSelectionChanged(String selectedDisease, String selectedType) {
    // debugPrint('Selected Disease: $selectedDisease');
    // debugPrint('Selected Type: $selectedType');
    // Perform any other actions based on the selected values
    disease = selectedDisease;
    type = selectedType;
  }

  @override
  Widget build(BuildContext context) {
    try {
      final jsonMap = jsonDecode(widget.qrCodeData);
      if (jsonMap != null && jsonMap is Map) {
        final tableRows = <TableRow>[];
        jsonMap.forEach((key, value) {
          tableRows.add(TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    key.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Paitent Information',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Table(
                        border: TableBorder.all(),
                        children: tableRows,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DiseaseSelect(
                      buildSubmitSection: handleSelectionChanged,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSubmitButton(jsonMap)
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        throw const FormatException('Invalid JSON data');
      }
    } catch (e) {
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
        body: const SafeArea(
          child: Center(
            child: Text(
              'Invalid QR Code',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSubmitButton(final jsonData) {
    return ElevatedButton(
      onPressed: () {
        jsonData['disease'] = disease;
        jsonData['type'] = type;
        _submitJsonData(jsonData);
      },
      child: const Text('Submit'),
    );
  }

  Future<void> _submitJsonData(final jsonData) async {
    final url = uploadAPIUrl; // Replace with your API endpoint
    // try {
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(jsonData),
    //   );
    debugPrint('response: $jsonData');

    //   if (response.statusCode == 200) {
    //     debugPrint('API request successful');
    //   } else {
    //     debugPrint('API request failed');
    //   }
    // } catch (error) {
    //   debugPrint('Error: $error');
    // }
  }
}
