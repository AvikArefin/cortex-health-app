import 'package:flutter/material.dart';

class DiseaseSelect extends StatefulWidget {
  @override
  _DiseaseSelectState createState() => _DiseaseSelectState();
}

class _DiseaseSelectState extends State<DiseaseSelect> {
  String? selectedDisease;
  String? selectedType;
  List<String> diseases = [
    'Diabetes',
    'Hypertension',
    'Asthma',
    'Arthritis',
    'Depression'
  ];
  Map<String, List<String>> types = {
    'Diabetes': ['Type 1 Diabetes', 'Type 2 Diabetes', 'Gestational Diabetes'],
    'Hypertension': [
      'Essential Hypertension',
      'Secondary Hypertension',
      'Malignant Hypertension'
    ],
    'Asthma': [
      'Allergic Asthma',
      'Non-allergic Asthma',
      'Exercise-induced Asthma'
    ],
    'Arthritis': [
      'Osteoarthritis',
      'Rheumatoid Arthritis',
      'Psoriatic Arthritis'
    ],
    'Depression': [
      'Major Depressive Disorder',
      'Persistent Depressive Disorder',
      'Bipolar Disorder'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Diagnosis',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const Text(
            //   'Select Disease',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedDisease,
              hint: const Text('Select a Disease'),
              onChanged: (String? value) {
                setState(() {
                  selectedDisease = value;
                  selectedType =
                      null; // Reset selected city when changing country
                });
              },
              items: diseases.map((String disease) {
                return DropdownMenuItem<String>(
                  value: disease,
                  child: Text(disease),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            selectedDisease != null
                ? Column(
                    children: [
                      // Text(
                      //   'Select a Type in $selectedDisease:',
                      //   style: const TextStyle(
                      //       fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      // const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: selectedType,
                        hint: const Text('Select a Type'),
                        onChanged: (String? value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                        items: types[selectedDisease!]!.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
            selectedDisease != null && selectedType != null
                ? const Column(
                    children: [
                      // Text(
                      //   'Selected Country: $selectedDisease',
                      //   style: const TextStyle(fontSize: 18),
                      // ),
                      SizedBox(height: 10),
                      // Text(
                      //   'Selected City: $selectedType',
                      //   style: const TextStyle(fontSize: 18),
                      // ),
                    ],
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
