import 'package:udemy_flutter_section11/data/categories.dart';
import 'package:udemy_flutter_section11/model/grocery_item.dart';

final groceryItems = [
  GroceryItem(
      id: 'a', name: 'Milk', quantity: 1, categories: categories[Items.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      categories: categories[Items.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      categories: categories[Items.meat]!),
];
