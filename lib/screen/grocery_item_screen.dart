import 'package:flutter/material.dart';
import 'package:udemy_flutter_section11/data/dummy_items.dart';

class GroceryItemScreen extends StatelessWidget {
  const GroceryItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Item'),

      ),
      body: ListView.builder(itemCount: groceryItems.length, itemBuilder: (BuildContext context, int index) {
        final items=groceryItems[index];
        return ListTile(
          title:Text( items.name),
          trailing: Text('${items.quantity}'),
          leading: Container(
            height: 20,
            width: 20,
            color:items.categories.color ,
          ),
        );
      },),
    );
  }
}
