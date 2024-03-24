import 'package:udemy_flutter_section11/model/categories.dart';

class GroceryItem{
  final String id;
  final String name;
  final int quantity;
  final Categories categories;

 const GroceryItem({required this.id, required this.name, required this.quantity, required this.categories});
}