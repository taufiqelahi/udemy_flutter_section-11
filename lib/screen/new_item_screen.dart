import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_section11/data/categories.dart';
import 'package:udemy_flutter_section11/model/grocery_item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _fromKey = GlobalKey<FormState>();
  var _enterName = '';
  var _qunatity = 1;
  var _selectedCategory = categories[Items.fruit];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Items'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length >= 50) {
                    return 'Must be 1 to 50 character!';
                  }
                  return null;
                },
                onSaved: (b) {
                  _enterName = b!;
                },
                decoration: InputDecoration(
                  label: Text('enter name'),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: _qunatity.toString(),
                      onSaved: (b) {
                        _qunatity = int.parse(b!);
                      },
                      decoration: InputDecoration(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'not valid';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                      child: DropdownButtonFormField(
                    value: _selectedCategory,
                    items: [
                      for (final item in categories.entries)
                        DropdownMenuItem(
                            value: item.value,
                            child: Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  color: item.value.color,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(item.value.categories)
                              ],
                            ))
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ))
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _fromKey.currentState!.reset();
                      },
                      child: Text('Reset')),
                  ElevatedButton(
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          _fromKey.currentState!.save();
                          print(_enterName);
                          print(_qunatity);
                        }
                        Navigator.of(context).pop(GroceryItem(
                            id: DateTime.now().toIso8601String(),
                            name: _enterName,
                            quantity: _qunatity,
                            categories: _selectedCategory!));
                      },
                      child: Text('Add'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
