import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_section11/data/categories.dart';
import 'package:udemy_flutter_section11/model/grocery_item.dart';
import 'package:http/http.dart' as http;


class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _fromKey = GlobalKey<FormState>();
  var _enterName = '';
  var _qunatity = 1;
  var _selectedCategory = categoryValue[Items.fruit];
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
                      for (final item in categoryValue.entries)
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
                                Text(item.value.title)
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
                      onPressed: () async{
                        if (_fromKey.currentState!.validate()) {
                          _fromKey.currentState!.save();
                          final url=Uri.https('udemy-flutter-a2778-default-rtdb.firebaseio.com','shopping_list.json');
                       await http.post(url,headers:{
                          "content-type":"application/json",
                        },body: json.encode({
                          'name':_enterName,
                          'quantity':_qunatity,
                          'categories':{
                            'title':_selectedCategory!.title,
                            'color':_selectedCategory!.color.toString()
                          }
                        }));
                        }
                     if(!context.mounted){
                      return;
                     }
                        Navigator.of(context).pop();
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
