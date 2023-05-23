import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/apps/shoppingList/data/categories.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:uuid/uuid.dart';

import '../models/grocery_item_model.dart';

const uuid = Uuid();

String? baseUrl = FlutterConfig.get('FIREBASE_URL');

class ShoppingListService {
  static final shoppingListTable =
      FirebaseFirestore.instance.collection("shopping_list");

  static Future<bool> addItem(GroceryItem item) async {
    try {
      await shoppingListTable.add({
        'name': item.name,
        'quantity': item.quantity,
        'category': item.category.title,
      });
      return true;
    } catch (err) {
      throw Exception('');
    }
  }

  static Future<List<GroceryItem>> getItems() async {
    try {
      final responseData = await shoppingListTable.get();
      final List<GroceryItem> itemInstances = [];
      for (final item in responseData.docs) {
        final groceryData = item.data();
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == groceryData['category'])
            .value;

        itemInstances.add(GroceryItem(
          id: item.id,
          name: groceryData['name'],
          quantity: groceryData['quantity'],
          category: category,
        ));
      }
      return itemInstances;
    } catch (err) {
      return Future.error('Somethings wrong');
    }
  }

  static Future<bool> removeItem(String id) async {
    try {
      shoppingListTable.doc(id).delete();
      return true;
    } catch (err) {
      throw Exception();
    }
  }
}
