import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udemy_flutter_section11/data/categories.dart';
import 'package:udemy_flutter_section11/model/categories.dart';
import 'package:udemy_flutter_section11/model/grocery_item.dart';
import 'package:udemy_flutter_section11/screen/new_item_screen.dart';
import 'package:http/http.dart' as http;

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen({super.key});

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  List<GroceryItem> categoryItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    Widget content = categoryItems.isEmpty
        ? Center(
            child: Text('No items'),
          )
        : ListView.builder(
            itemCount: categoryItems.length,
            itemBuilder: (BuildContext context, int index) {
              final items = categoryItems[index];
              return Dismissible(
                key: ValueKey(items.id),
                onDismissed: (v) {
                  categoryItems.remove(items);
                },
                child: ListTile(
                  title: Text(items.name),
                  trailing: Text('${items.quantity}'),
                  leading: Container(
                    height: 20,
                    width: 20,
                    color: items.categories.color,
                  ),
                ),
              );
            },
          );
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Item'),
        actions: [
          IconButton(
              onPressed: () async {
               await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewItemScreen()));
               loadData();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }

  void loadData() async {
    final url = Uri.https('udemy-flutter-a2778-default-rtdb.firebaseio.com',
        'shopping_list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData = jsonDecode(response.body);
    List<GroceryItem> category = [];
    print(listData);
    for (final list in listData.entries) {
      category.add(GroceryItem(
          id: list.key,
          name: list.value['name'],
          quantity: list.value['quantity'],
          categories: Categories(list.value['categories']['title'],
              getColorFromString(list.value['categories']['color']))));
    }
    setState(() {
      categoryItems = category;
    });
  }
}

Color getColorFromString(String colorString) {
  // Extract the hexadecimal color value from the string
  final hexColor = colorString.split('(0x')[1].split(')')[0];

  // Parse the hexadecimal string as an integer
  int colorValue = int.tryParse(hexColor, radix: 16) ?? 0xFF000000;

  // Create and return the Color object
  return Color(colorValue).withOpacity(1.0); // Optionally set opacity if needed
}
