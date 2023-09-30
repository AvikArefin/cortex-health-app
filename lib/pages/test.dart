import 'package:flutter/material.dart';

class CountryCityWidget extends StatefulWidget {
  @override
  _CountryCityWidgetState createState() => _CountryCityWidgetState();
}

class _CountryCityWidgetState extends State<CountryCityWidget> {
  String? selectedCountry;
  String? selectedCity;
  List<String> countries = [
    'Country 1',
    'Country 2',
    'Country 3',
    'Country 4',
    'Country 5'
  ];
  Map<String, List<String>> countryCities = {
    'Country 1': ['City 1', 'City 2', 'City 3', 'City 4', 'City 5'],
    'Country 2': ['City 6', 'City 7', 'City 8', 'City 9', 'City 10'],
    'Country 3': ['City 11', 'City 12', 'City 13', 'City 14', 'City 15'],
    'Country 4': ['City 16', 'City 17', 'City 18', 'City 19', 'City 20'],
    'Country 5': ['City 21', 'City 22', 'City 23', 'City 24', 'City 25'],
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a Country',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCountry,
                hint: const Text('Select a country'),
                onChanged: (String? value) {
                  setState(() {
                    selectedCountry = value;
                    selectedCity =
                        null; // Reset selected city when changing country
                  });
                },
                items: countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a City',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCity,
                hint: const Text('Select a city'),
                onChanged: (String? value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                items: selectedCountry != null
                    ? countryCities[selectedCountry!]!.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList()
                    : [],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
