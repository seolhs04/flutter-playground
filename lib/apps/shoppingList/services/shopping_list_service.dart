import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

import '../data/categories.dart';
import '../models/grocery_item_model.dart';

String? baseUrl = FlutterConfig.get('FIREBASE_URL');

class ShoppingListService {
  static Future<bool> addItem(GroceryItem item) async {
    try {
      final url = Uri.parse('$baseUrl/shopping-list.json');
      await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': item.name,
            'quantity': item.quantity,
            'category': item.category.title,
          },
        ),
      );
      return true;
    } catch (err) {
      throw Exception('');
    }
  }

  static Future<List<GroceryItem>> getItems() async {
    try {
      final url = Uri.parse('$baseUrl/shopping-list.json');
      final response = await http.get(url);
      if (response.body == 'null') return [];
      List<GroceryItem> itemInstances = [];
      final Map<String, dynamic> listData = json.decode(response.body);
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;
        itemInstances.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
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
      final url = Uri.parse('$baseUrl/shopping-list/$id.json');
      await http.delete(url);
      return true;
    } catch (err) {
      throw Exception();
    }
  }
}
