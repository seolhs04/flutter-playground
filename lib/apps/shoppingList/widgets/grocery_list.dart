import 'package:flutter/material.dart';
import 'package:flutter_app/apps/shoppingList/models/grocery_item_model.dart';
import 'package:flutter_app/apps/shoppingList/providers/theme_mode_cubit.dart';
import 'package:flutter_app/apps/shoppingList/services/shopping_list_service.dart';
import 'package:flutter_app/apps/shoppingList/widgets/new_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  Future<List<GroceryItem>> _loadedItems = ShoppingListService.getItems();

  void _addItem() {
    setState(() {
      _loadedItems = ShoppingListService.getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<GroceryItem>(
                MaterialPageRoute(builder: (ctx) {
                  return NewItem(addItem: _addItem);
                }),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      floatingActionButton:
          BlocBuilder<ThemeModeCubit, bool>(builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            BlocProvider.of<ThemeModeCubit>(context).changeDarkMode();
          },
          child: Icon(state ? Icons.light_mode_outlined : Icons.light_mode),
        );
      }),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No items added yet'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(snapshot.data![index].id),
              onDismissed: (direction) {
                ShoppingListService.removeItem(snapshot.data![index].id);
              },
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: snapshot.data![index].category.color,
                ),
                trailing: Text(snapshot.data![index].quantity.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
