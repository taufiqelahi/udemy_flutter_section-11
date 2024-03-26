import 'package:flutter/material.dart';
import 'package:udemy_flutter_section11/model/grocery_item.dart';
import 'package:udemy_flutter_section11/screen/new_item_screen.dart';

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen({super.key});

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  List<GroceryItem>categoryItems=[];
  @override
  Widget build(BuildContext context) {
    Widget content=categoryItems.isEmpty ?Center(child: Text('No items'),):ListView.builder(
      itemCount:categoryItems.length,
      itemBuilder: (BuildContext context, int index) {
        final items = categoryItems[index];
        return Dismissible(
          key: ValueKey(items.id),
          onDismissed: (v){
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
                final newItems= await Navigator.push<GroceryItem>(context,
                    MaterialPageRoute(builder: (context) => NewItemScreen()));
               setState(() {
                 categoryItems.add(newItems!);
               });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body:content ,
    );
  }
}
