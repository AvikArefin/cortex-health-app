import 'package:flutter/material.dart';

class CategorySelectionWidget extends StatefulWidget {
  @override
  _CategorySelectionWidgetState createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  String selectedCategory;
  String selectedSubcategory;

  final List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
  ];

  final Map<String, List<String>> subcategories = {
    'Category 1': ['Subcategory 1', 'Subcategory 2', 'Subcategory 3'],
    'Category 2': ['Subcategory 4', 'Subcategory 5', 'Subcategory 6'],
    'Category 3': ['Subcategory 7', 'Subcategory 8', 'Subcategory 9'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(
          labelText: 'Category',
          value: selectedCategory,
          items: categories,
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue;
              selectedSubcategory =
                  null; // Reset subcategory when changing the category
            });
          },
        ),
        if (selectedCategory != null)
          Category(
            labelText: 'Subcategory',
            value: selectedSubcategory,
            items: subcategories[selectedCategory],
            onChanged: (newValue) {
              setState(() {
                selectedSubcategory = newValue;
              });
            },
          ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Perform any action with the selected category and subcategory
            print('Selected Category: $selectedCategory');
            print('Selected Subcategory: $selectedSubcategory');
          },
          child: Text('Save Selection'),
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String labelText;
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  const Category({
    Key key,
    @required this.labelText,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category Selection Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Category Selection')),
        body: CategorySelectionWidget(),
      ),
    );
  }
}
