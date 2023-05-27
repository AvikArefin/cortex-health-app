// ignore_for_file: prefer_const_constructors

// import 'package:cortex/QR.dart';
import 'package:cortex/pages/about.dart';
import 'package:cortex/pages/upload.dart';
import 'package:cortex/pages/upload_data.dart';
import 'package:cortex/urls/urlstring.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      if (_scanBarcode != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRCodeResultPage(_scanBarcode),
          ),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(right: 10, top: 25),
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 180,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Cortex Health',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).primaryColor.withOpacity(.5),
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Detection Models')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Brain Tumor
                      dieseaseSlot(
                        string: 'brain',
                        title: 'Brain tumor',
                        modelName: 'Brain Tumor',
                        stringUrl: brainAPIUrl,
                      ),
                      // Pneumonia
                      dieseaseSlot(
                        string: 'lung',
                        title: 'Pneumonia',
                        modelName: 'Lung Disease',
                        stringUrl: lungAPIUrl,
                      ),
                      // Liver Disease
                      dieseaseSlot(
                        string: 'liver',
                        title: 'Liver diesease',
                        modelName: 'Liver Disease',
                        stringUrl: liverAPIUrl,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      scanQR();
                    },
                    child: const Text('Upload Data'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector dieseaseSlot(
      {required String string,
      required String title,
      required String modelName,
      required String stringUrl}) {
    return GestureDetector(
      onTap: () {
        debugPrint("$string slot pressed");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UploadPage(modelName: modelName, stringUrl: stringUrl)),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            height: 200,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage('assets/images/$string.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Colors.black38,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
