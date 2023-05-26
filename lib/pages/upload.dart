import 'dart:convert';
import 'dart:io';
import 'package:cortex/components/circleboundary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class UploadPage extends StatefulWidget {
  final String modelName;
  final String stringUrl;
  const UploadPage({Key? key, required this.stringUrl, required this.modelName})
      : super(key: key);

  @override
  UploadPageState createState() => UploadPageState();
}

class UploadPageState extends State<UploadPage> {
  File? image;
  int? cx, cy, r; // ADDED
  String? resultString, resultString2;
  String? OutputName;
  String? OutputConfidence;

  Future<void> uploadImage(ImageSource imageSource) async {
    var pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(widget
            .stringUrl), // Parses whichever string gets passed from the previous page
      );

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        pickedImage.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          // Handle success
          debugPrint('Image uploaded successfully');

          // ADDED
          // --------------------------------------------------
          Map<String, dynamic> detectionResult =
              jsonDecode(await response.stream.bytesToString());
          debugPrint(detectionResult.toString());
          OutputName = detectionResult['predicted-class'];
          OutputConfidence =
              (100.0 * detectionResult['confidence']).toStringAsFixed(2);

          // Check if 'box' element exists
          if (detectionResult.containsKey('box') &&
              detectionResult['box'] is Map) {
            Map<String, dynamic> box = detectionResult['box'];

            // Check if 'cx', 'cy', and 'radius' keys exist in 'box' element
            if (box.containsKey('cx') &&
                box.containsKey('cy') &&
                box.containsKey('radius')) {
              debugPrint('Answer - ${box['cx'].runtimeType}');
              cx = box['cx'];
              cy = box['cy'];
              r = box['radius'];
              debugPrint('cx: $cx, cy: $cy, r: $r');
            } else {
              print(
                  'One or more required keys are missing in the "box" element.');
            }
          } else {
            print('The "box" element is empty or missing.');
          }

          setState(() {
            resultString = 'X: $cx, Y: $cy, Radius: $r';
          });

          debugPrint(await response.stream.bytesToString());
          // -------------------------------------------------
        } else {
          // Handle error
          debugPrint('Image upload failed with status ${response.statusCode}');
          throw Exception('Failed to get results. >>> ELSE');
        }
      } catch (e) {
        // Handle exception
        debugPrint('Error uploading image: $e');
        throw Exception('Failed to get results. >>> Caught E');
      }
    }
  }

  Color boundingBorderColor = Colors.deepPurple.withOpacity(0.25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cortex Health'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: boundingBorderColor,
            ),
            margin: const EdgeInsets.all(20),
            child: image == null
                ? const Center(
                    child: Text('Pick Image'),
                  )
                : Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 300,
                            width: 300,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      if (cx != null && cy != null && r != null)
                        CircleBoundary(cx: cx!, cy: cy!, r: r!)
                      // CircleBoundary(cx: -10, cy: -10, r: 20)
                    ],
                  ),
          ),
          Text(
            '${widget.modelName} Detection Model',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          if (OutputName != null) ...[
            Text(
              'Type: ${OutputName!} \nConfidence: ${OutputConfidence!}%\nFound at: ${resultString!}',
              style: const TextStyle(fontSize: 18),
            )
            // ? if ()
          ] else ...[
            const CircularProgressIndicator()
          ],
          Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  label: const Text('Camera Upload'),
                  onPressed: () {
                    setState(() {
                      OutputName = null;
                      cx = 0;
                      cy = 0;
                      r = 0;
                    });
                    uploadImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                ),
                const SizedBox(width: 5),
                ElevatedButton.icon(
                  label: const Text('Upload Photo'),
                  onPressed: () {
                    setState(() {
                      OutputName = null;
                      cx = 0;
                      cy = 0;
                      r = 0;
                    });
                    uploadImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.upload_file),
                ),
                const SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
