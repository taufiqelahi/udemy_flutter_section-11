
import 'package:flutter/material.dart';

import 'package:udemy_flutter_section11/model/categories.dart';
enum Items {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}


const categories = {
  Items.vegetables:  Categories(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Items.fruit: Categories(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Items.meat: Categories(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Items.dairy: Categories(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Items.carbs: Categories(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Items.sweets: Categories(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Items.spices: Categories(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Items.convenience: Categories(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Items.hygiene: Categories(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Items.other: Categories(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
