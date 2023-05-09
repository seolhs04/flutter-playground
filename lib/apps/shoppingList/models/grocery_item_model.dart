import 'category_model.dart';

class GroceryItem {
  final String id, name;
  final int quantity;
  final Category category;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}
