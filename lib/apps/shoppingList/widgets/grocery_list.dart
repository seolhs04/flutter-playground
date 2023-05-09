import 'package:flutter/material.dart';
import 'package:flutter_app/apps/shoppingList/models/grocery_item_model.dart';
import 'package:flutter_app/apps/shoppingList/providers/theme_mode_cubit.dart';
import 'package:flutter_app/apps/shoppingList/widgets/new_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) {
        return const NewItem();
      }),
    );
    if (newItem == null) return;
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet'));
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              onPressed: _addItem,
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
        body: content);
  }
}
